# Local Dev Environment for Fabric Testbed

Author: George Papadimitriou

This github repository can be used to instantiate a local development environment for the Fabric Testbed. It creates a Jupyterhub environment similar to the one offered by Fabric, that runs in docker containers locally in your laptop or desktop.

## Description of the available files and folders

_Docker_. This folder contains all the scripts and recipes needed to prepare the Docker image for the deployment.

_Docker/build.sh_. This is the script to be invoked to generate the Docker image. It passes the needed build arguments automatically, such as the fablib version to be used.

_fabric\_config_. This folder contains all the needed configuration for successfully interacting with Fabric Testbed.

_fabric\_config/keys_. This folder is used for your bastion and sliver ssh keys. The folder's content has been excluded from tracking via the .gitignore file.

_fabric\_config/tokens_. This folder is used for your fabric token. Each project requires its own token. The folder's content has been excluded from tracking via the .gitignore file.

_fabric\_config/fabric\_rc_. This file contains Fabric variables that are used by fablib to prepopulate fields.

_fabric\_config/ssh\_config_. This file contains ssh configuration that is used from within the container to interact with fabric vm instances.

_helpers_. This folder contains some helper scripts to help keep your token alive for as long as possible.

_projects_. This folder is allocated for you jupyter notebooks and project specific code.

## Deployment Steps

### Step 1: Generated the Docker image
--------------------------------------
During the build process the fabric user will be created in the image with uid=your_current_uid and gid=your_current_primary_gid. This will allow attaching volumes and accessing files easy from within and outside the container.<br>
If you want to edit the fablib version alter the FABLIB_VERSION variable in /Docker/build.sh.
```
cd Docker
./build.sh
```

### Step 2: Install your Bastion and Sliver Keys
------------------------------------------------
Place your Bastion and Sliver keys in the *fabric_config/keys* folder. The file names should follow the naming convention as seen bellow.
```
fabric_bastion_key
fabric_bastion_key.pub
fabric_sliver_key
fabric_sliver_key.pub
```

### Step 3: Install your Fabric Token (fabric_config/tokens/fabric.json)
------------------------------------------------------------------------
Create a new file *fabric_config/tokens/fabric.json* and paste your Fabric token.
To generated a token follow the instructions on Fabric's documentation.

### Step 4: Update Fabric RC (fabric_config/fabric_rc)
------------------------------------------------------
Replace the placeholders (lines 4,5) with your project id and bastion username. 
```
line 4: export FABRIC_PROJECT_ID=<YOUR_PROJECT_ID>
line 5: export FABRIC_BASTION_USERNAME=<YOUR_BASTION_USERNAME>
```
### Step 5: Update the SSH Config (fabric_config/ssh_config)
------------------------------------------------------------
Replace the placeholders (lines 6,14) with your bastion username.
```
line 6: User <YOUR_BASTION_USERNAME>
line 14: ProxyJump <YOUR_BASTION_USERNAME>@bastion-1.fabric-testbed.net:22
```

### Step 6: Starting Up the Service
------------------------------------------------------------
```
docker compose up -d
```

### Step 7: Taking Down the Service
------------------------------------------------------------
```
docker compose down
```
