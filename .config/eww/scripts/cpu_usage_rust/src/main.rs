use serde_json;
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::thread::sleep;
use std::time::Duration;

struct CoreStat {
    total: u64,
    idle: u64,
}

fn read_stats() -> HashMap<String, CoreStat> {
    let file = File::open("/proc/stat").expect("Failed to open /proc/stat");
    let reader = BufReader::new(file);
    let mut stats = HashMap::new();

    for line in reader.lines() {
        let line = line.expect("Failed to read line");
        let parts: Vec<&str> = line.split_whitespace().collect();
        if parts.is_empty() || !parts[0].starts_with("cpu") {
            continue;
        }
        let cpu_name = parts[0].to_string();
        if cpu_name == "cpu" {
            continue; // Skip aggregate CPU line
        }

        let numbers: Vec<u64> = parts[1..]
            .iter()
            .take(8)
            .map(|s| s.parse().unwrap_or(0))
            .collect();

        let user = *numbers.get(0).unwrap_or(&0);
        let nice = *numbers.get(1).unwrap_or(&0);
        let system = *numbers.get(2).unwrap_or(&0);
        let idle = *numbers.get(3).unwrap_or(&0);
        let iowait = *numbers.get(4).unwrap_or(&0);
        let irq = *numbers.get(5).unwrap_or(&0);
        let softirq = *numbers.get(6).unwrap_or(&0);
        let steal = *numbers.get(7).unwrap_or(&0);

        let total = user + nice + system + idle + iowait + irq + softirq + steal;
        let idle_total = idle + iowait;

        stats.insert(cpu_name, CoreStat { total, idle: idle_total });
    }

    stats
}

fn main() {
    let stats1 = read_stats();
    sleep(Duration::from_millis(500));
    let stats2 = read_stats();

    let mut cores: Vec<&String> = stats1.keys().filter(|k| stats2.contains_key(*k)).collect();
    cores.sort_by_key(|k| k[3..].parse::<u32>().unwrap_or(0));

    let mut usage = Vec::new();
    for core_name in cores {
        let s1 = stats1.get(core_name).unwrap();
        let s2 = stats2.get(core_name).unwrap();

        let delta_total = s2.total.checked_sub(s1.total).unwrap_or(0);
        let delta_idle = s2.idle.checked_sub(s1.idle).unwrap_or(0);

        let cpu_usage = if delta_total == 0 {
            0.0
        } else {
            ((delta_total - delta_idle) as f64 / delta_total as f64) * 100.0
        };

        usage.push(cpu_usage);
    }

    println!("{}", serde_json::to_string(&usage).unwrap());
}
