# molecule_ubuntu_2404

A [Packer](https://www.packer.io/) project to build an image of Ubuntu Server
24.04 suitable for use with
[dtmo/molecule_driver_libvirt](https://github.com/dtmo/molecule_driver_libvirt).

The built image is a default installation of Ubuntu Server 24.04 with all
package updates applied.

## Installed Packages

* [Cloud-init](https://cloudinit.readthedocs.io/en/latest/): Cloud-init is used
  by `dtmo/molecule_driver_libvirt` to perform initial VM configuration. It is
  also used to pass installation config to the Subiquity installer, and so
  appears to be installed by default. See
  [Cloud-init and autoinstall interaction](https://canonical-subiquity.readthedocs-hosted.com/en/latest/index.html) for more details.
* [QEMU Guest Agent](https://wiki.qemu.org/Features/GuestAgent): QEMU Guest
  Agent is used to provide hypervisor access to the VM.
  `dtmo/molecule_driver_libvirt` uses it to determine when Cloud-init has
  finished initialising the VM, and to retrieve network information about the
  guest OS.

## Image Usage

As the built image is intended to be used with `dtmo/molecule_driver_libvirt`,
and therefore configured with Cloud-init, there are no default accounts or
credentials baked into the image.

When used with `dtmo/molecule_driver_libvirt` the image will be configured with
the Cloud-init
[NoCloud Datasource](https://cloudinit.readthedocs.io/en/latest/reference/datasources/nocloud.html)
using configuration set by the Molecule driver.

## Building

### Pre-requisites

* HashiCorp Packer must be installed to execute the build process. See:
  [Install Packer](https://developer.hashicorp.com/packer/install).

* QEMU is required for the Packer
  [QEMU Integration](https://developer.hashicorp.com/packer/integrations/hashicorp/qemu)
  to perform the image build.

### Build Process

```bash
packer init .
packer build .
```

The built QCOW2 image will be written to: `output-ubuntu2402/packer-ubuntu2404`.
