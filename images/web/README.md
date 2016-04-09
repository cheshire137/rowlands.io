docker run \
-p 80:80 \
--link ldap:ldap \
-v /home/jgrowlands/Code/github.com/jgrowl/rowlands.io/web/etc/ansible/roles/jgrowl.configure_web:/etc/ansible/roles/jgrowl.configure_web \
--rm -it --name=web jgrowl/web
