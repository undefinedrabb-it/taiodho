const numberOfPages = 100;

const memory = new WebAssembly.Memory({
    // See build.zig for reasoning
    initial: numberOfPages,
    maximum: numberOfPages,
});


WebAssembly
    .instantiateStreaming(
        fetch("./taiodho.wasm"),
        {
            env: {
                consoleLog: (arg) => console.log(arg),
                memory: memory,
            },
        })
    .then((result) => {
        const wasmMemoryArray = new Uint8Array(memory.buffer);
        const bufferSize = result.instance.exports.getBufferSize();

        const canvas = document.getElementById("main");
        canvas.width = result.instance.exports.getWidth();
        canvas.height = result.instance.exports.getHeight();

        const context = canvas.getContext("2d");
        const imageData = context.createImageData(canvas.width, canvas.height);
        context.clearRect(0, 0, canvas.width, canvas.height);


        
        
        const render = () => {
            result.instance.exports.update();

            const bufferOffset = result.instance.exports.getBufferPointer();
            const imageDataArray = wasmMemoryArray.slice(
                bufferOffset,
                bufferOffset + bufferSize
            );

            imageData.data.set(imageDataArray);

            context.clearRect(0, 0, canvas.width, canvas.height);
            context.putImageData(imageData, 0, 0);
        };

        render();
        if (false) {
            setInterval(() => {
                render();
            }, 250);
        }
    });