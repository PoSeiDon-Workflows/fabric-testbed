#!/usr/bin/env bash

rm /home/fabric/work/fabric_config/fabric_rc
rm /home/fabric/work/chameleon_config/chameleon_rc

ln -s $MY_FABRIC_RC_FILE /home/fabric/work/fabric_config/fabric_rc
ln -s $MY_CHAMELEON_RC_FILE /home/fabric/work/chameleon_config/chameleon_rc

source /home/fabric/work/fabric_config/fabric_rc
source /home/fabric/work/chameleon_config/chameleon_rc

jupyter lab --no-browser --port=$MY_JUPYTER_PORT --ip=0.0.0.0
