const std = @import("std");
const fs = std.fs;

fn check(big: i32, small: i32) bool {
    if (big < small or big - small < 1 or big - small > 3) return false;
    return true;
}

fn check_safety_asc(list: []const i32) bool {
    for (0..list.len - 1) |i| {
        if (!check(list[i + 1], list[i])) return false;
    }
    return true;
}

fn check_safety_asc_dapmed(list: []const i32) bool {
    var i: usize = 0;
    var one_safe: bool = true;
    while (i < list.len - 1) {
        if (!check(list[i + 1], list[i])) {

            if (one_safe) {
                one_safe = false;
                if (i + 2 < list.len) {
                    if (i == 0) {
                        if (!check(list[i + 2], list[i])) {
                            if (!check(list[i + 2], list[i + 1])) return false;
                        } else {
                            i += 1;
                        }
                    } else {
                        if (!check(list[i + 2], list[i])) return false;
                        i += 1;
                    }
                }
            } else return false;

        }
        i += 1;
    }
    return true;
}

fn check_safety_desc(list: []const i32) bool {
    for (0..list.len - 1) |i| {
        if (!check(list[i], list[i + 1])) return false;
    }
    return true;
}

fn check_safety_desc_dapmed(list: []const i32) bool {
    var i: usize = 0;
    var one_safe: bool = true;
    while (i < list.len - 1) {
        if (!check(list[i], list[i + 1])) {

            if (one_safe) {
                one_safe = false;
                if (i + 2 < list.len) {
                    if (i == 0) {
                        if (!check(list[i], list[i + 2])) {
                            if (!check(list[i + 1], list[i + 2])) return false;
                        } else {
                            i += 1;
                        }
                    } else {
                        if (!check(list[i], list[i + 2])) return false;
                        i += 1;
                    }
                }
            } else return false;

        }
        i += 1;
    }
    return true;
}

fn get_flow_of_list(list: []const i32) bool {
    // true = asc
    // false = desc
    var avrg: i32 = 0;
    for (0..list.len - 1) |i| {
        const a = list[i];
        const b = list[i + 1];

        if (a - b < 0) avrg -= 1;
        if (a - b > 0) avrg += 1;
    }

    if (avrg < 0) return true;
    return false;
}

pub fn main() anyerror!void {
    // Allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // opening file
    const input_file = try fs.cwd().openFile("puzzle.input", .{});
    defer input_file.close();
    const input_reader = input_file.reader();
    
    const all_data = try input_reader.readAllAlloc(allocator, 10241024);
    defer allocator.free(all_data);

    var line_iterator = std.mem.tokenizeAny(u8, all_data, "\n");
    
    // iterrating through the file
    // Part 1
    var s1: i32 = 0;
    // Part 2
    var s2: i32 = 0;
    while (line_iterator.next()) |line| {
        var nr_iterator = std.mem.tokenizeAny(u8, line, " ");
        var list = std.ArrayList(i32).init(allocator);
        defer list.deinit();

        while (nr_iterator.next()) |nr_str| {
            const nr = try std.fmt.parseInt(i32, nr_str, 10);
            try list.append(nr);
        }

        const safety = if (get_flow_of_list(list.items)) check_safety_asc(list.items) else check_safety_desc(list.items);
        if (safety) s1 += 1;

        const safety_damped = if (get_flow_of_list(list.items)) check_safety_asc_dapmed(list.items) else check_safety_desc_dapmed(list.items);
        if (safety_damped) s2 += 1;
    }

    std.debug.print("Part 1: {d}\n", .{s1});
    std.debug.print("Part 2: {d}\n", .{s2});
}