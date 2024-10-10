#!/bin/bash

export NODE_ENV=production

case $(uname -sm) in
  "Darwin arm64") cassowary="./cassowary_Darwin_arm64" ;;
  "Linux x86_64") cassowary="./cassowary_Linux_x86_64" ;;
  *) echo "Unsupported platform!"; exit 1; ;;
esac

commands=(
  "bun ./react-hello-world.bun.jsx"
  "deno -A ./react-hello-world.deno.jsx"
  "npx swc -C jsc.parser.syntax=ecmascript -C jsc.parser.jsx=true -C jsc.transform.react.runtime=automatic ./react-hello-world.node.jsx -o ./react-hello-world.node.mjs ; node ./react-hello-world.node.mjs"
)

for cmd in "${commands[@]}"; do
  eval "$cmd &"
  PID=$!
  echo "Spawned: '$cmd' with PID $PID..."
  sleep 1
  $cassowary run -u http://127.0.0.1:3000 -c 10 -n 100000
  kill $PID
done
