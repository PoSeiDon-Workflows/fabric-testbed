#!/usr/bin/env bash

source /home/fabric/work/fabric_config/fabric_rc
source /home/fabric/work/chameleon_config/chameleon_rc

export SHELL=/bin/bash

jupyter lab --no-browser --port=$MY_JUPYTER_PORT --ip=0.0.0.0
