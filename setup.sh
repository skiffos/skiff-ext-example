#!/bin/bash
set -eo pipefail

source ./setup.env
cd ./skiffos
bash $@
