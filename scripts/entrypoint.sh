#!/usr/bin/env bash

source ~/.bashrc
conda activate pipeline-env

case "$1" in
  webserver)
  sleep 10
  exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.iopub_data_rate_limit=100000000
  ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac
