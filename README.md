# React SSR Benchmarking for Bun, Deno and Node.js

> [!NOTE]
> This is similar to the benchmark on bun.sh's homepage but with the results made easy to reproduce,
> https://github.com/oven-sh/bun/tree/main/bench/react-hello-world

1. Install Bun, Deno and Node.js from their respective sources.

2. Run `npm install` to install packages

3. Run `./benchmark.sh` to test all runtimes.

## Observations

Bun appears consistently to be the fastest amongst the three runtimes followed by Deno and then Node.js.

The difference in performance is noticeably improved from React 18 to React 19 specifically for the Bun runtime. This is because `react-dom/server` has a special entrypoint for Bun and loads a Bun-specific server runtime optimized specifically for it, such as using the non-standard [`type: "direct"` ReadableStream](https://bun.sh/docs/api/streams#direct-readablestream) in [ReactDOMFizzServerBun.js](https://github.com/facebook/react/blob/566b0b0f14356f6e1a13722cac005c2f94f4c3f9/packages/react-dom/src/server/ReactDOMFizzServerBun.js#L75).
