#!/bin/bash

# Load profile (see bellow)
. $1
shift

# Convert relevant variables to a YAML document.
function fYamlConfig {
  cat << EOS
    domain: $DOMAIN
    admin_email: $ADMIN_EMAIL
    mongodb:
      admin_user: $MONGODB_ADMIN_USER
      admin_password: $MONGODB_ADMIN_PASSWORD
      nightscout_user: $MONGODB_NIGHTSCOUT_USER
      nightscout_password: $MONGODB_NIGHTSCOUT_PASSWORD
    nightscout:
      base_url: $NIGHTSCOUT_BASE_URL
      api_secret: $NIGHTSCOUT_API_SECRET
      dexcom_user: $DEXCOM_USER
      dexcom_password: $DEXCOM_PASSWORD
EOS
}

# Launch playbook
ansible-playbook -i $REMOTE_HOST, -u $REMOTE_USER -e config=<(fYamlConfig) main.yaml $@

# Note about profiles:
# --------------------
# A profile should contain at least the REMOTE_HOST and REMOTE_USER environment variables.
# Variables used in the fYamlConfig function should be defined as well. All content exposed
# this way will be available in the playbook via the extcfg dictionary.
