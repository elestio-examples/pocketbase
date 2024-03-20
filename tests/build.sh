#!/usr/bin/env bash
api_url="https://api.github.com/repos/pocketbase/pocketbase/releases/latest"
response=$(curl -s $api_url)
latest_release_tag=$(echo $response | grep -o '"tag_name": *"[^"]*"' | awk -F'"' '{print $4}' | sed 's/^v//')

sed -i "s~POCKETBASE_VERSION_TO_CHANGE~${latest_release_tag}~g" ./Dockerfile

docker buildx build . --output type=docker,name=elestio4test/pocketbase:latest | docker load