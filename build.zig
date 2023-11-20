// From https://github.com/daneelsan/minimal-zig-wasm-canvas
const std = @import("std");

const number_of_pages = 100;

pub fn build(b: *std.Build) void {
    // important that this is a shared library, otherwise it not be .wasm but .a
    const lib = b.addSharedLibrary(.{
        .name = "taiodho",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
            // .abi = .musl,

        },
        .optimize = .ReleaseSmall,
    });

    // <https://github.com/ziglang/zig/issues/8633>
    lib.global_base = 6560;
    lib.rdynamic = true;
    lib.import_memory = true;
    lib.stack_size = std.wasm.page_size;

    lib.initial_memory = std.wasm.page_size * number_of_pages;
    lib.max_memory = std.wasm.page_size * number_of_pages;

    const install_opt = .{ .dest_dir = .{ .override = .{ .custom = "../" } } };
    const artifact = b.addInstallArtifact(lib, install_opt);

    b.getInstallStep().dependOn(&artifact.step);
}
