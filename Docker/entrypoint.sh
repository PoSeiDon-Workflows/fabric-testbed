#!/usr/bin/env bash

source /home/fabric/work/fabric_config/fabric_rc

jupyter lab --no-browser --port=$MY_JUPYTER_PORT --ip=0.0.0.0
