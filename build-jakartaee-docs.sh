#!/bin/bash

# Step 1: Build jakartaee-documentation-ui
echo "Building jakartaee-documentation-ui..."
gulp bundle
if [ $? -ne 0 ]; then
  echo "Error: Failed to build jakartaee-documentation-ui."
  exit 1
fi
echo "Successfully built jakartaee-documentation-ui."

# Step 2: Switch to the jakartaee-documentation repository
cd ../jakartaee-documentation || { echo "Error: jakartaee-documentation directory not found."; exit 1; }
echo "Switched to jakartaee-documentation directory."

# Step 3: Create a local-antora-playbook.yml by copying the existing antora-playbook.yml
echo "Creating local-antora-playbook.yml..."
cp antora-playbook.yml local-antora-playbook.yml
if [ $? -ne 0 ]; then
  echo "Error: Failed to create local-antora-playbook.yml."
  exit 1
fi
echo "Successfully created local-antora-playbook.yml."

# Step 4: Update the ui.bundle.url in local-antora-playbook.yml
echo "Updating ui.bundle.url in local-antora-playbook.yml..."
sed -i '' "s|url: https://github.com/jakartaee/jakartaee-documentation-ui/releases/download/latest/ui-bundle.zip|url: ../jakartaee-documentation-ui/build/ui-bundle.zip|g" local-antora-playbook.yml
if [ $? -ne 0 ]; then
  echo "Error: Failed to update ui.bundle.url."
  exit 1
fi
echo "Successfully updated ui.bundle.url to use the local UI bundle."

# Step 5: Build jakartaee-documentation
echo "Building jakartaee-documentation..."
mvn compile -Pauthor-mode
if [ $? -ne 0 ]; then
  echo "Error: Failed to build jakartaee-documentation."
  exit 1
fi
echo "Successfully built jakartaee-documentation."

# End of script
