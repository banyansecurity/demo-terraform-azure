# Banyan Security demo for Azure environments using Terraform


## Prerequisities

To run this demo, you will need the following:

1. Azure account with credentials
2. An SSH key-pair for authentication into Linux VMs we'll create
2. Terraform CLI 0.14.9+, configured for Azure provisioning
3. Banyan account and admin API key, and a device with the Banyan Desktop App installed

For instructions on how to set these up, go to the [Prerequisities Details section](#prerequisities-details).


## Run it

Clone this repo to your machine. Edit the `locals.tf` file with details from your environment.

```tf
locals {
  name_prefix = "bnn-demo-azure"

  region = "westus3"
  ssh_key_path = "~/.ssh/id_rsa.pub"

  banyan_host = "https://team.console.banyanops.com/"
  banyan_api_key = "YOUR_BANYAN_API_KEY"
  banyan_org = "YOUR_BANYAN_ORG"
}
```

Then, provision all the resources:

```bash
terraform apply
```

Provisioning is broken up into 6 steps; the code is written so you can run it step-by-step by specifying each step during the apply as: `terraform apply -target=module.network`

1. **Network** - a new Resource Group with a virtual network and subnet
2. **Database** - an Azure Database for MySQL instance
3. **Application** - an VM instance that runs a demo website container
4. **Banyan Connector** - deploy an VM instance with the `connector` to create an outbound connection to the Banyan Global Edge network, so you can manage access to your Azure environment
5. **Banyan Policies** - create a few roles and policies to establish which users and devices can access your Azure environment
6. **Banyan Services** - publish the services that are deployed in your Azure environment for your end users

This first 3 steps get you a basic but representative Azure environment. The last 3 steps set up Banyan to provide secure remote access to this environment.


## Access your Azure resources
