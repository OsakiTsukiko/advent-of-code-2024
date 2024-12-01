const std = @import("std");
const fs = std.fs;

pub fn main() anyerror!void {
    // Allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    

    // defining lists
    var first_list = std.ArrayList(i32).init(allocator);
    defer first_list.deinit();
    var second_list = std.ArrayList(i32).init(allocator);
    defer second_list.deinit();


    // opening file
    const input_file = try fs.cwd().openFile("puzzle.input", .{});
    defer input_file.close();
    const input_reader = input_file.reader();
    
    const all_data = try input_reader.readAllAlloc(allocator, 10241024);
    defer allocator.free(all_data);

    var iterator = std.mem.tokenizeAny(u8, all_data, " \n");
    
    // iterrating through the file
    while (iterator.next()) |first| {
        const second = iterator.next().?;
        const first_nr = try std.fmt.parseInt(i32, first, 10);
        const second_nr = try std.fmt.parseInt(i32, second, 10);
        
        try first_list.append(first_nr);
        try second_list.append(second_nr);
    }


    // get owned lists from array lists
    const fl_owned = try first_list.toOwnedSlice();
    defer allocator.free(fl_owned);
    const sl_owned = try second_list.toOwnedSlice();
    defer allocator.free(sl_owned);

    // sort lists
    std.mem.sort(i32, fl_owned, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, sl_owned, {}, comptime std.sort.asc(i32));


    // part 1
    var sum_abs: i32 = 0;
    for (fl_owned, sl_owned) |first, second| {
        // std.debug.print("{d} {d}\n", .{first, second});
        sum_abs += @as(i32, @intCast(@abs(first - second)));
    }
    std.debug.print("Part 1: {d}\n", .{sum_abs});

    // part 2
    var sim_score: i32 = 0;
    for (fl_owned) |first| {
        const counter = std.mem.count(i32, sl_owned, &[_]i32{first});
        sim_score += first * @as(i32, @intCast(counter));
    }
    std.debug.print("Part 2: {d}\n", .{sim_score});
}