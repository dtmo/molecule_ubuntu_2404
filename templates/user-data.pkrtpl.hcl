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
  late-commands:
      # The kernel command line used to install Ubuntu has been persisted in the
      # GRUB_CMDLINE_LINUX_DEFAULT variable in /etc/default/grub. We don't want
      # to limit Cloud-init to only using the NoCloud datasource, so we need to
      # correct the configuration and update GRUB. We will keep the disablement
      # of predictable network interface names. See:
      # https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/#idontlikethishowdoidisablethis
    - curtin in-target -- sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0"/g' /etc/default/grub
    - curtin in-target -- update-grub