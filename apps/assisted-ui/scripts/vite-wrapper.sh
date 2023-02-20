#!/usr/bin/env bash
set -euo pipefail

command=$1
other_args=${@:2}

source scripts/env.sh

if [[ "$command" =~ ^(preview|serve)$ ]];then
  export "$(grep -E '^AIUI_APP_API_URL' .env.development.local)"
fi

if [[ "$command" =~ ^(preview)$ ]]; then
    if [ ! -d  build ]; then
      yarn build
    else
      echo 'Previewing files using the existing '\''build'\'' directory'
    fi
fi

yarn vite "$command" -c vite.config.ts "$other_args"