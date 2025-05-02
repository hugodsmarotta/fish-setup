#!/bin/sh

for i in curl fish; do
  if ! command -v "$i" >/dev/null 2>&1; then
    echo "$i is not installed. Please install it first."
    exit 1
  fi
done
