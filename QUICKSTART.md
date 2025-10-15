# Quick Start Guide

## Prerequisites
- NixOS installation media booted
- Internet connection available

## Installation Steps

### 1. Partition your disk (example for UEFI)
```bash
# Example partitioning - adjust for your disk
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MB -8GB
parted /dev/sda -- mkpart primary linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

# Format partitions
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

# Mount filesystems
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
```

### 2. Clone this repository
```bash
cd /mnt
git clone https://github.com/z4roc/zanix.git
cd zanix
```

### 3. Generate hardware configuration
```bash
# Choose your hostname: zaroc-4070, zaroc-gb3, or zaroc-server
HOSTNAME=zaroc-4070

# Generate hardware config (this will overwrite the template)
nixos-generate-config --show-hardware-config > hosts/${HOSTNAME}/hardware-configuration.nix
```

### 4. Review and adjust hardware configuration
```bash
# Edit if needed
nano hosts/${HOSTNAME}/hardware-configuration.nix
```

### 5. Install NixOS
```bash
# Install with your chosen hostname
sudo nixos-install --flake .#${HOSTNAME}

# Set password for zaroc user when prompted
```

### 6. Reboot
```bash
reboot
```

## Post-Installation

### First Login
1. Login as user `zaroc` with the password you set during installation
2. The system will boot into SDDM (display manager)
3. Choose between KDE Plasma or Hyprland session

### Move configuration to your home directory
```bash
# Copy the zanix directory to your home
sudo cp -r /mnt/zanix /home/zaroc/
sudo chown -R zaroc:users /home/zaroc/zanix
cd /home/zaroc/zanix
```

### Making Changes
```bash
# Edit configuration files
nano hosts/$(hostname)/configuration.nix
nano modules/common.nix
nano home/zaroc.nix

# Rebuild system
sudo nixos-rebuild switch --flake .#$(hostname)
```

### Updating System
```bash
# Update flake inputs (nixpkgs, home-manager, hyprland)
nix flake update

# Rebuild with new versions
sudo nixos-rebuild switch --flake .#$(hostname)
```

## Useful Commands

```bash
# Test configuration without applying
sudo nixos-rebuild test --flake .#$(hostname)

# Build configuration without activating
sudo nixos-rebuild build --flake .#$(hostname)

# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Garbage collect old generations
sudo nix-collect-garbage -d
```

## Customization Tips

### Change timezone
Edit `modules/common.nix`:
```nix
time.timeZone = "America/New_York";  # Change from Europe/Berlin
```

### Add packages
System-wide packages in `modules/common.nix`:
```nix
environment.systemPackages = with pkgs; [
  # Add your packages here
];
```

User packages in `home/zaroc.nix`:
```nix
home.packages = with pkgs; [
  # Add your packages here
];
```

### Configure Git
Edit `home/zaroc.nix`:
```nix
programs.git = {
  userName = "Your Name";
  userEmail = "your.email@example.com";
};
```

## Troubleshooting

### Build fails
```bash
# Check flake syntax
nix flake check

# Show detailed error
sudo nixos-rebuild switch --flake .#$(hostname) --show-trace
```

### NVIDIA issues (zaroc-4070)
If you encounter NVIDIA driver issues, try:
```nix
# In hosts/zaroc-4070/configuration.nix
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
# or
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
```

### Laptop battery optimization (zaroc-gb3)
Additional tweaks in `hosts/zaroc-gb3/configuration.nix`:
```nix
services.power-profiles-daemon.enable = false;  # Conflicts with TLP
powerManagement.powertop.enable = true;
```

## Getting Help

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Discourse](https://discourse.nixos.org/)
