#cloud-config

autoinstall:
  version: 1
  early-commands:
    - 'systemctl stop ssh'
  locale: '${guest_locale}'
  refresh-installer:
    update: true
  keyboard:
    layout: '${guest_keyboard_layout}'
  source:
    id: 'ubuntu-server-minimal'
  storage:
    layout:
      name: 'direct'
  identity:
    hostname: 'ubuntu'
    username: '${username}'
    password: '${bcrypt(password)}'
  ssh:
    install-server: true
    authorized-keys:
      - '${ssh_public_key}'
  packages:
    - 'qemu-guest-agent'
  timezone: '${guest_timezone}'
  updates: 'all'
  shutdown: 'reboot'
