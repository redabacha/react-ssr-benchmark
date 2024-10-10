import { renderToReadableStream } from "react-dom/server";
const headers = {
  headers: {
    "Content-Type": "text/html",
  },
};

const App = () => (
  <html>
    <body>
      <h1>Hello World</h1>
      <p>This is an example.</p>
    </body>
  </html>
);

Bun.serve({
  port: 3000,
  async fetch(req) {
    return new Response(await renderToReadableStream(<App />), headers);
  },
});

console.log("Server running");
