#!/usr/bin/env sh
set -e


if [ ! -f /etc/ansible/inventories ]; then
    ln -s /docker/inventories /etc/ansible/inventories
fi

#if [ ! -L ~/.ssh ]; then
#    rm -Rf ~/.ssh/
#fi

if [ ! -f ~/.ssh ]; then
    ln -sf /docker/.ssh ~/
fi

if [ "$1" = 'sh' ]; then
# Generate a site-wide script
cat > /usr/local/bin/site.sh <<EOF
#!/usr/bin/env sh
echo "Bootstrapping environment..."
ansible-playbook${@:2}
EOF
chmod u+x /usr/local/bin/site.sh
exec sh
else
    echo "Bootstrapping environment..."
    ansible-playbook $@
fi
