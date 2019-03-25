#!/bin/bash

sfdx force:org:create -f config/project-scratch-def.json -a HCADK2 --setdefaultusername -d 1

sfdx force:package:install --package 04t1C000000AoPO -w 20 

sfdx force:mdapi:deploy --deploydir mdapi-source/app-config

sfdx force:mdapi:deploy --deploydir mdapi-source/data-config

sfdx force:mdapi:deploy --deploydir mdapi-source/org-config

sfdx force:source:push 

sfdx force:user:permset:assign -n HealthCloudPermissionSetLicense
sfdx force:user:permset:assign -n HealthCloudAdmin

# Use external script to manage the data loading
./dataInit.sh

sfdx force:org:open
