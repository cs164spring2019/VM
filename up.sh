
#!/bin/bash

# Create VM, with bridged networking enabled.
bakerx run app-vm alpine3.9-simple -b

# Get ssh command
ssh_cmd=$(bakerx ssh-info app-vm|tr -d '"')

# Use heredoc to send script over ssh
$ssh_cmd << 'END_DOC'

# Install packages
apk add --update --no-cache nodejs npm git
# Get projects
git clone https://github.com/CSC-DevOps/App
# Setup project
cd App
npm install

exit
END_DOC

echo $ssh_cmd
