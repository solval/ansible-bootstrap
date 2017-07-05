#!/bin/bash
#
# Bootstrap ansible launcher virtualenv directory

set -e; set -u;

if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "ERROR: can't determine OS distribution, exiting."
    exit 1
fi

working_dir=$(pwd)
aptreqs=${APT_REQ_LIST:-requirements/$ID-$VERSION_ID.txt}
yumreqs=${YUM_REQ_LIST:-requirements/$ID-$VERSION_ID.txt}
pipreqs=${PIP_REQ_LIST:-requirements/python.txt}
ansreqs=${ANS_REQ_LIST:-requirements/ansible.yml}
venvdir=${VENV_DIR:-$working_dir/venv}
roledir=${ROLE_DIR:-$working_dir/roles}

# install required OS packages
case $ID in
ubuntu)
    [ -f "$aptreqs" ] && xargs -a <(awk '/^\s*[^#]/' $aptreqs) -r -- sudo -E apt -y install
    ;;
fedora|centos)
    [ -f "$yumreqs" ] && xargs -a <(awk '/^\s*[^#]/' $yumreqs) -r -- sudo -E yum -y install
    ;;
*)
    echo "ERROR: OS $ID not yet supported, exiting."
    exit 1
    ;;
esac

# set up virtualenv
virtualenv $venvdir
set +e; set +u
source ${venvdir}/bin/activate
set -e; set -u

# install required python packages
for pipreq in $pipreqs; do
  [ -f "$pipreq" ] && pip install -r $pipreq;
done

# install required ansible roles
for ansreq in $ansreqs; do
  [ -f "$ansreqs" ] && ansible-galaxy install -c -p $roledir -r $ansreq
done

# finalize
deactivate
