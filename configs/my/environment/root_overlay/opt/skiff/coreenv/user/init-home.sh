#!/bin/sh
echo "Chowning mount for ${1}..."
chown ${1}:${1} /home/$1
if [ ! -f /home/${1}/.user_inited ]; then
    echo "Setting up /etc/skel for ${1}..."
    rsync -rhv \
        --ignore-existing  \
        --owner --group \
        --chown ${1}:${1} \
        /etc/skel/ /home/${1}/
    touch /home/${1}/.user_inited
fi
if [ ! -d /home/${1}/catkin_ws ]; then
    echo "Setting up catkin_ws for ${1}..."
    sudo -u $1 bash <<"EOF"
        cd $HOME
        # source /opt/ros/melodic/setup.bash
        mkdir -p ./catkin_ws/src
        # cd ./catkin_ws
        # catkin_make
EOF
fi


