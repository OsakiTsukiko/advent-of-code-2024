use std::fs::File;
use std::vec::Vec;
use std::io::{self, BufRead};

fn main() {
    let mut left: Vec<i32> = Vec::new();
    let mut right: Vec<i32> = Vec::new();
    
    let file = File::open("puzzle.input").unwrap();
    let reader = io::BufReader::new(file);

    for line in reader.lines() {
        let line = line.unwrap();
        let nr: Vec<&str> = line.split_whitespace().collect();
        let n1 = nr[0].parse::<i32>().unwrap();
        let n2 = nr[1].parse::<i32>().unwrap();
        left.push(n1);
        right.push(n2);
    }

    left.sort();
    right.sort();

    // Paer 1
    let mut s1: i32 = 0;
    for i in 0..left.len() {
        let a = left.get(i).unwrap();
        let b = right.get(i).unwrap();

        s1 += (*a - *b).abs();
    }

    println!("Part 1: {}", s1);

    // Part 2
    let mut s2: i32 = 0;
    for a in left {
        let cnt = right.iter().filter(|&i| *i == a).count();
        s2 += cnt as i32 * a;
    }

    println!("Part 2: {}", s2);
}
