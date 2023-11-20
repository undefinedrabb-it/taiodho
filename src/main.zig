const std = @import("std");
const geo = @import("geo.zig");
const color = @import("color.zig");

const Color3 = color.Color3;
const Color = color.Color;
const Vec3 = geo.Vec3;
const Ray = geo.Ray;

const assert = std.debug.assert;

extern fn consoleLog(arg: u32) void;

var buffer = std.mem.zeroes(
    [height][width]Color,
);
export fn getBufferPointer() [*]u8 {
    return @ptrCast(&buffer);
}
export fn getBufferSize() usize {
    return width * height * 4;
}

const width = 1600;
export fn getWidth() usize {
    return width;
}
const height = 900;
export fn getHeight() usize {
    return height;
}

const focalLength = 1.0;

const aspectRatio = width / height;
const viewportHeight = 2.0;
const viewportWidth = viewportHeight * aspectRatio;

const camera = Vec3{ .x = 0.0, .y = 0.0, .z = 0.0 };

const viewport_u = Vec3{ .x = viewportWidth, .y = 0.0, .z = 0.0 };
const viewport_v = Vec3{ .x = 0.0, .y = -viewportHeight, .z = 0.0 };

const pixel_delta_u = viewport_u.divS(width);
const pixel_delta_v = viewport_v.divS(height);

const viewport_upper_left = camera
    .sub(viewport_u.divS(2.0))
    .sub(viewport_v.divS(2.0))
    .sub(.{ .x = 0.0, .y = 0.0, .z = focalLength });

const pixel00_loc = viewport_upper_left.add(pixel_delta_u.add(pixel_delta_v).divS(2.0));

fn rayColor(ray: Ray) Color {
    var unit_direction = ray.direction.unit_v();
    var a = (unit_direction.y + 1.0) * 0.5;
    var white = Color3{ .r = 1.0, .g = 1.0, .b = 1.0 };
    var blue = Color3{ .r = 0.4, .g = 0.5, .b = 1.0 };

    return color.fromVec3(white.toVec3().mutS(1.0 - a).add(blue.toVec3().mutS(a)));
}

export fn update() void {
    for (0..height) |y| {
        for (0..width) |x| {
            const d = pixel00_loc
                .add(pixel_delta_u.mutS(@floatFromInt(x)))
                .add(pixel_delta_v.mutS(@floatFromInt(y)));
            const r: Ray = .{ .origin = camera, .direction = d.sub(camera) };

            buffer[y][x] = rayColor(r);
        }
    }
}
