# This is a work in progress - Many things are probably broke

    
    docker-compose -f development.yml -p rowlandsio up
    docker-compose -f development.yml -p rowlandsio rm -f
    

# Setup instructions 


## Obtain a docker host and source docker environment variables

### For example, on DigitalOcean:

    export DO_ACCESS_TOKEN=<API TOKEN>
    docker-machine create --driver digitalocean --digitalocean-access-token $DO_ACCESS_TOKEN mail
    eval "$(docker-machine env mail)"
    
## Copy the env template and edit with your own variables 

`cp env.template env`
    
## Bring up your new mail server

`docker-compose -p examplecom up -d`
    
## Setup postfixadmin

`http://mail.example.com/postfixadmin/setup.php`
    
## Setup rainloop
    
`http://mail.example.com/?admin`

## Setup your DNS records

![DNS Records](images/mail-dns-records.png "dns-records")

### Obtain DKIM key from container

`docker exec examplecom_mail_1 cat /etc/mail/mail.txt`

# Debug any issues
    
`docker exec -it examplecom_mail_1 bash`

# Development instructions

## Build the image

`docker build -t jgrowl/mail .`

# Notes

## These files/folders are important to backup and keep safe

- /etc/mail/dkim.key
- /usr/lib/courier/pop3d.pem
- /usr/lib/courier/imapd.pem

# Matrix 
docker run -v /tmp/data:/data --rm -e SERVER_NAME=mail.rowlands.io silviof/docker-matrix generate
docker run -d -p 8448:8448 -p 3478:3478 -v /tmp/data:/data silviof/docker-matrix start


docker-compose -p rowlandsio up -d matrix_data
docker run --volumes-from rowlandsio_matrix_data_1 --rm -e SERVER_NAME=mail.rowlands.io silviof/docker-matrix generate

docker run --volumes-from rowlandsio_matrix_data_1 --rm busybox /bin/bash


docker run -p 8448:8448 -it --name matrix -v /home/jgrowlands/Code/github.com/jgrowl/rowlands.io/matrix/jgrowl.configure_synapse:/etc/ansible/roles/jgrowl.configure_synapse --rm jgrowl/matrix


