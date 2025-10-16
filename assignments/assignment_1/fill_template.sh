#!/usr/bin/env nix-shell
#! nix-shell -p bash envsubst -i bash

set -euo pipefail

if [ "$#" != 3 ]; then
    echo "Usage: fill_template.sh <NAME> <SURNAME> <CITY>"
    exit 1
fi

if [ ! -f "./Resume Template.md" ]; then
    echo "Error: cannot find template"
    exit 1
fi

export NAME="$1"
export SURNAME="$2"
export CITY="$3"

envsubst < "./Resume Template.md" > "./resumes/$NAME $SURNAME ($CITY).md"

echo "Successfully wrote out: './resumes/$NAME $SURNAME ($CITY).md'"
