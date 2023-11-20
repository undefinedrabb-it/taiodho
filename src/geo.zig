pub const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn divS(self: @This(), s: f32) Vec3 {
        return .{ .x = self.x / s, .y = self.y / s, .z = self.z / s };
    }
    pub fn mutS(self: @This(), s: f32) Vec3 {
        return .{ .x = self.x * s, .y = self.y * s, .z = self.z * s };
    }

    pub fn addS(self: @This(), s: f32) Vec3 {
        return .{ .x = self.x + s, .y = self.y + s, .z = self.z + s };
    }

    pub fn sub(self: @This(), other: Vec3) Vec3 {
        return .{ .x = self.x - other.x, .y = self.y - other.y, .z = self.z - other.z };
    }
    pub fn add(self: @This(), other: Vec3) Vec3 {
        return .{ .x = self.x + other.x, .y = self.y + other.y, .z = self.z + other.z };
    }

    pub fn len(self: @This()) f32 {
        return @sqrt(self.lenSquared());
    }
    fn lenSquared(self: @This()) f32 {
        return self.x * self.x + self.y * self.y + self.z * self.z;
    }

    pub fn unit_v(self: @This()) Vec3 {
        return self.divS(self.len());
    }
};

pub const Point3 = Vec3;

pub const Ray = struct {
    origin: Point3,
    direction: Vec3,
    pub fn at(self: @This(), t: f32) Point3 {
        return self.origin + t * self.direction;
    }
};
