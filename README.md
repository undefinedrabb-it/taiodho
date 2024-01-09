### Description
Browser raytracer in zig.
# taiodho

## About
Taiodho is a raytracer written in Zig, following [Ray Tracing in One Weekend](https://raytracing.github.io/) book. <br/>
You can see a live demo at https://undefinedrabb-it.github.io/taiodho/.

## Quick Start 

### Requirement
You need only `zig`  and python optinally. <br/>
Tested zig version: `0.12.0-dev.1396+f6de3ec96`.

### Usage
Compile:

```bash
zig build
```
Run a simple python3 server in the project root directory:

```
python -m http.server 8080
```
Then open in a browser `http://localhost:8080`.

## Contributions
If you would like to contribute feel free to create an issue, fork and create a PR. 

## Acknowledgments
Special thanks to:
- @RayTracing for creating an open source book about raytracing: https://raytracing.github.io/, 
- @daneelsan for the minimal zig wasm example: https://github.com/daneelsan/minimal-zig-wasm-canvas.