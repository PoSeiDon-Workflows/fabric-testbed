# Local Dev Environment for Fabric Testbed

Author: George Papadimitriou

This github repository can be used to instantiate a local development environment for the Fabric Testbed. It creates a Jupyterhub environment similar to the one offered by Fabric, that runs in docker containers locally in your laptop or desktop.

## Description of the available files and folders

_Docker_. This folder contains all the scripts and recipes needed to prepare the Docker image for the deployment.
_Docker/build.sh_. This is the script to be invoked to generate the Docker image. It passes the needed build arguments automatically, such as the fablib version to be used.
_fabric\_config_. This folder contains all the needed configuration for successfully interacting with Fabric Testbed.
_fabric\_config/keys_. This folder is used for your bastion and sliver ssh keys. The folder's content has been excluded from tracking via the .gitignore file.
_fabric\_config/tokens_. This folder is used for your fabric token. Each project requires its own token, so if you need to interact with multiple Fabric projects you can have multiple tokens saved here. The folder's content has been excluded from tracking via the .gitignore file.
_fabric\_config/my\_fabric\_rc_. This file contains Fabric variables that are used by fablib to prepopulate fields.
_fabric\_config/ssh\_config_. This file contains ssh configuration that is used from within the container to interact with fabric vm instances.
