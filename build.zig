const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("zgl", .{
        .root_source_file = b.path("src/zgl.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run library tests");
    const main_tests = b.addTest(.{
        .name = "zgl-tests",
        .root_source_file = b.path("src/zgl.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(main_tests);
    test_step.dependOn(&b.addRunArtifact(main_tests).step);
}
