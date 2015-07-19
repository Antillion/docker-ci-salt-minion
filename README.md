# Salt Minion for Continuous Integration

This is a simple Salt Minion docker container that should only be used for Continuous Integration, local development, etc. as it is (intentionally) highly insecure.

# Salt Master

We have a separate [Salt Master docker file](https://registry.hub.docker.com/u/antillion/ci-salt-master/builds_history/259885/) that you can find in the registry.

# What it does

Sets up a simple Salt Minion and a SSH server.

SSH is enabled to allow our integration tests to log in and restart the minion (we do this once we clear out the master's keys on each test).

# Environment Variables

 - `SALT_VERSION`: version of salt to install, default: 2014.7.4
 - `SALT_PASSWORD`: the password that will be used for any accounts
 - `SALTMASTER`: the hostname of the salt master, default: `saltmaster`
 - `MINION_NAME`: name of the minion, defaults to: `ci_minion`

# Volumes
None
