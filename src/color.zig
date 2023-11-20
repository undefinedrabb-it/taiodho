const Vec3 = @import("geo.zig").Vec3;

pub const Color = packed struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

pub const Color3 = struct {
    r: f32,
    g: f32,
    b: f32,
    pub fn toVec3(c: @This()) Vec3 {
        return Vec3{
            .x = c.r,
            .y = c.g,
            .z = c.b,
        };
    }
};

pub fn fromVec3(v: Vec3) Color {
    return Color{
        .r = @as(u8, @intFromFloat(v.x * 255.0)),
        .g = @as(u8, @intFromFloat(v.y * 255.0)),
        .b = @as(u8, @intFromFloat(v.z * 255.0)),
        .a = 255,
    };
}
