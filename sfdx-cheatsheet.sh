# This cheatsheet contains the most often used SFDX commands for beginners to get a jumpstart.
# Hint. it is highly recommended to use `-h` to check the usage of any SFDX commands and corresponding parameters.
# For instance, use `sfdx force:auth:web:login -h` to checke what `-d` `-a` parameters do

# List down all supported dx commands:
sfdx force:doc:commands:list

# Check current DebHub and Scratch Org status
sfdx force:org:list

# Log into DevHub via the web browser
sfdx force:auth:web:login -d -a DevHub

# Log out all connected orgs
sfdx force:auth:logout -a --noprompt 

# Set alias for a connected environment. Format: [alias=username]
fdx force:alias:set DevHub=xi.xiao@gmail.com

# change password for a org with alias "tempTest"
sfdx force:user:password:generate -u tempTest

# Log into a sandbox environment
sfdx force:auth:web:login --setalias sandbox1 --instanceurl https://test.salesforce.com

# Set one Dev Hub as the default
# Note `defaultdevhubusername` can be either username or DevHub alias
sfdx force:config:set defaultdevhubusername=DevHub

# Create a scratch org with alias tempTest
sfdx force:org:create -s -f config/project-scratch-def.json -a tempTest

# Set an existing scratch org as default
sfdx force:config:set defaultusername=<username|alias>

# run the LTS tests constructed in the app named jasmineTests.app
sfdx force:lightning:test:run -a jasmineTests.app

# Open the scratch org with alias 'tempTest' in browser
sfdx force:org:open -u tempTest

# Open the default scratch org with lightning experience
sfdx force:org:open --path one/one.app

# Delete a scratch org with alias tempTest
# Note. `-u` accepts either an username or a scratch org alias
sfdx force:org:delete -u tempTest

# Create a project locally in folder MyProject
sfdx force:project:create -n MyProject

# Check changes between the scratch org and local project
sfdx force:source:status

# Pull changes from the associated scratch org
sfdx force:source:pull

# Retrieve an Apex class from the org by mdapi
sfdx force:source:retrieve --metadata ApexClass:MyNewClass

# Push changes from the associated scratch org
sfdx force:source:push

# Assign a permission set to the current logged in user
sfdx force:user:permset:assign -n myCustomPermSet

# Export some sample data from the scratch org
sfdx force:data:tree:export -q "SELECT Name, Location__Latitude__s, Location__Longitude__s FROM Account WHERE Location__Latitude__s != NULL AND Location__Longitude__s != NULL" -d ./data

# Import sample data to the current associated/default scratch org
sfdx force:data:tree:import --sobjecttreefiles data/Account.json

# Scaffold a lightning App structure
sfdx force:lightning:app:create -n AccountLocatorApp -d force-app/main/default/aura/

# Scaffold a lightning component structure
sfdx force:lightning:component:create -n myComponent -d force-app/main/default/aura

# Scaffold a lightning event structure
sfdx force:lightning:event:create -n myEvent -d force-app/main/default/aura

# Install LTS testing framework
# More about LTS: https://forcedotcom.github.io/LightningTestingService/
sfdx force:lightning:test:install

# Update sfdx version
sfdx update

# Convert source code to a package. Be ready to deploy to sandbox
sfdx force:source:convert -d mdapi/ --packagename package_name

# Deploy to connected environment without running test; wait 5mins for the report
sfdx force:mdapi:deploy -d mdapi/ -u xisb3 -l NoTestRun -w 5

# Check connected environment deploying job result
sfdx force:mdapi:deploy:report

# Run all unit tests with code coverage statistics
sfdx force:apex:test:run -cy -l RunAllTestsInOrg -w 5 -r human

# assume a package.xml containing list of meta-data is in place, the goal is to retrieve meta-data from sandbox and conver to a DX format so we can save these metadata to git as well as push into scratch org 
sfdx force:mdapi:retrieve -r retrieveCodeoutput -k package.xml -u sandbox1
unzip retrieveCodeoutput/unpackaged.zip
# then move the unpacked folder to a DX project root path
sfdx force:mdapi:convert --rootdir unpackaged/
# above command will convert metadata info and save to current DX project
