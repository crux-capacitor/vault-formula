# Hashicorp Vault Formula

This formula installs, configures, initializes, and manages a production-ready Hashicorp Vault cluster. It is designed to run on AWS but can really be used to set up a Vault cluster on any Linux systems.

It is highly customizable via the `config.yaml` file and makes getting set up with Vault an absolute breeze.

This formula enables you to:

* Install, configure, and initialize a brand new Vault instance

* Scale up your Vault cluster 

* Add and manage Vault policies

* Configure Vault auditing 

* View the status of your Vault

* Seal and unseal your Vault

* Upgrade the version of Vault

Customization of the formula is done via the `config.yaml` file. Each individual SLS file that is involved in either the deployment or management of your Vault installation has a section in this file, and each section has various options that can be tuned or configured for your needs.

## Configuring the installed version

In the `install` section of the `config.yaml` file, the `version` option is used to piece together the name of the zip file that is extracted to get the Vault binary installed on your Vault servers. 

The install state will first reach out to the Internet for the download. If that fails, it will search this formula's path for an `installers\` directory and look for the zip file there. The Vault executable itself will be extracted to `/root/vault_<version>/` and then symlinked to `/usr/local/bin/vault`.

 