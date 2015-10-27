
docker run --rm -it jgrowl/ldap

docker run -p 389:389 -p 636:636  -v /home/jgrowlands/Code/github.com/jgrowl/rowlands.io/ldap/etc/ansible/roles/jgrowl.configure_ldap:/etc/ansible/roles/jgrowl.configure_ldap --rm -it --name=ldap jgrowl/ldap


ldapsearch -x -h localhost -b dc=my-domain,dc=com -D "cn=Manager,dc=my-domain,dc=com" -w secret
ldapsearch -x -h localhost -b dc=my-domain,dc=com -D "cn=admin,dc=my-domain,dc=com" -w secret


ldapinit

ldapadd -w secret -x -D "cn=Manager,dc=my-domain,dc=com" -f /etc/openldap/ldif/create_users_and_groups.ldif 

/var/lib/openldap/openldap-data
/usr/local/etc/ssl/ldap
