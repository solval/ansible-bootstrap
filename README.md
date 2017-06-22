# ansible-bootstrap
Prepare ansible launcher virtualenv directory

# Usage
The scripts/bootstrap.sh script will:
- install OS packages, as per requirements file
- initialize a Python virtualenv directory
- install Python packages, as per requirements file (including ansible)
- install Ansible roles, as per requirements file

You are about to configure requirements for your
plays either by modifying requirements/ files,
or by using your own, setting env variables.

Default setup can be tweaked using shell environment variables:
```bash
$APT_REQ_LIST (defaults to requirements/$ID-$VERSION_ID.txt - as per /etc/os-release)
$YUM_REQ_LIST (defaults to requirements/$ID-$VERSION_ID.txt - as per /etc/os-release)
$PIP_REQ_LIST (defaults to requirements/python.txt)
$ANS_REQ_LIST (defaults to requirements/ansible.yml)
$VENV_DIR (defaults to $(pwd)/venv)
$ROLE_DIR (defaults to $(pwd)/roles)
```
