accelerator = "kvm"

disk_size = "5G"

// List available machine types with `qemu-system-x86_64 -machine help`
machine_type = "q35"

memory = 4096

ssh_username = "packer"
ssh_password = "packer"
ssh_timeout  = "60m"

cpus = 2
