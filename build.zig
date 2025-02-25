const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addLibrary(.{
        .name = "yaml",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(lib);
    lib.linkLibC();
    lib.addCSourceFiles(.{
        .files = &.{
            "src/api.c",
            "src/dumper.c",
            "src/emitter.c",
            "src/loader.c",
            "src/parser.c",
            "src/reader.c",
            "src/scanner.c",
            "src/writer.c",
        },
        .flags = &.{
            "-std=c99",
            "-DYAML_VERSION_MAJOR=0",
            "-DYAML_VERSION_MINOR=2",
            "-DYAML_VERSION_PATCH=5",
            "-DYAML_VERSION_STRING=\"0.2.5\"",
            "-DYAML_DECLARE_STATIC",
            "-DCRT_SECURE_NO_WARNINGS",
        },
    });
    lib.addIncludePath(b.path("include"));

    const test_step = b.step("test", "Run tests");

    const test_paths: []const []const u8 = &.{
        "tests/example-deconstructor-alt.c",
        "tests/example-deconstructor.c",
        "tests/example-reformatter-alt.c",
        "tests/example-reformatter.c",
        "tests/run-dumper.c",
        "tests/run-emitter.c",
        "tests/run-emitter-test-suite.c",
        "tests/run-loader.c",
        "tests/run-parser.c",
        "tests/run-parser-test-suite.c",
        "tests/run-scanner.c",
        "tests/test-reader.c",
        "tests/test-version.c",
    };
    for (test_paths) |test_path| {
        const test_exe = b.addExecutable(.{
            .name = std.fs.path.basename(test_path),
            .root_module = b.createModule(.{
                .target = target,
                .optimize = optimize,
            }),
        });
        test_exe.linkLibC();
        test_exe.linkLibrary(lib);
        test_exe.addCSourceFile(.{
            .file = b.path(test_path),
            .flags = &.{"-std=c99"},
        });
        test_exe.addIncludePath(b.path("include"));
        const run_test_exe = b.addRunArtifact(test_exe);
        run_test_exe.expectExitCode(0);
        test_step.dependOn(&run_test_exe.step);
        b.installArtifact(test_exe);
    }
}
