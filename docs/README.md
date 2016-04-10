## What is this?

This project provides a complete website infrastructure. The goal is to have a generic skeleton for complete infrastructure management. It's all dependent on Docker containers.

## What can I do with it?

Through flat configuration files, you can create an entire production infrastructure with multiple pluggable services.

## Raison D'être

Managing website infrastructure, configuration, and secrets is painful. Stuff is spread everywhere, you may forget where things are, such as IP addresses or how you configured something. You might have moved something to another server or not remember how things are done. When you have a system with even a single node, it can be frustrating managing what's on it. It gets exponentially more difficult when you have multiple nodes and you try to have fault tolerance, logging, and service discovery across all nodes.

This project lets you manage an entire system of servers and services through one location, just in text files. It's intended to be easy to understand and search through, easy to scale up and down to support production-level systems as well as simple systems.

## How do I use it?

    cp -R .private.example .private

.private will hold all the stuff you need to persist and keep secret. All the files in .private are configuration files. You might have folders like .ssh and .docker. You will also have an inventories folder.

### Inventories Folder

This contains specific environment configuration, e.g., development and production. Most of the configuration lies in this folder. Inside each environment, define:

1. The process in which you bring up Docker hosts. You can use Docker machine for example.
1. A hosts file, like in Ansible. The hosts file defines what you're putting on each host, e.g., a mail server on server X, a web server on server Y.
1. There's a host\_vars folder, like in Ansible. It contains variables for each host.

Once you have .private copied with the skeleton that's included, you have to do some configuration. There's a configuration file at .private/inventories/_yourEnvironment_/host\_vars/setup\_hosts.yml. Edit this file and fill in your Digital Ocean access token. This is just for the included example, you could use Amazon EC2 or some other service.

The included example uses tinc. You can run a script to generate tinc RSA keys. Inside host\_vars, you'll have .yml files for each host name. You need a public and private key for each host that should go in the configuration variables for that host.

Run `make`. For the included example, this will create three nodes on Digital Ocean, they'll all have tinc installed, they'll be connected via a virtual network and be able to communicate with each other. It's spinning up a container and running Ansible inside that container. Ansible goes and configures other nodes. When Ansible finishes, it'll give you an output of successes and failures. If you have no failure warnings, all your nodes should be up.

Run `make sh`. This will drop you into a local container that acts as your bastion server. It's a shell with the environment set up to run Ansible if you want. All the Docker machine configuration is set up so you can `docker-machine ssh` into the nodes you have running. You can go poke around on each node, ping the other nodes on the virtual network, etc.

For the included example, you can go to [Digital Ocean](http://digitalocean.com) and see your new droplets.
