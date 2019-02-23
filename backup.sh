#! /usr/bin/env bash

command -v kaggle >/dev/null 2>&1 || {
  echo >&2 "kaggle not installed.  Aborting.";
  exit 1;
}

username=$(kaggle config view | grep 'username' | sed -E 's/.*username:[[:space:]]*(.*)/\1/')
kernels=$(kaggle kernels list --mine --csv | tail -n +2 | cut -d, -f1)

echo "Backing up kernels for '$username'";

for kernel in $kernels; do
  kaggle kernels pull "$kernel" --path "$kernel" --metadata
done;
