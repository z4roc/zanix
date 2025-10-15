# zanix
My NixOS config with flakes

## Overview

This repository contains NixOS configurations for three systems:
- **zaroc-4070**: Desktop PC with NVIDIA RTX 4070 GPU
- **zaroc-gb3**: Samsung laptop
- **zaroc-server**: Server PC with AMD GPU

All systems use:
- **Display Manager**: SDDM
- **Desktop Environment**: KDE Plasma 6
- **Window Manager**: Hyprland (Wayland compositor)
- **User**: zaroc
- **Home Manager**: For user-level configuration

## Structure

```
.
├── flake.nix                 # Main flake configuration
├── hosts/
│   ├── zaroc-4070/          # NVIDIA Desktop PC
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── zaroc-gb3/           # Samsung Laptop
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   └── zaroc-server/        # Server PC (AMD GPU)
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules/
│   └── common.nix           # Shared configuration
└── home/
    └── zaroc.nix            # Home Manager configuration
```

## Installation

1. **Boot into NixOS installer**

2. **Clone this repository:**
   ```bash
   git clone https://github.com/z4roc/zanix.git
   cd zanix
   ```

3. **Generate hardware configuration for your system:**
   ```bash
   # Generate hardware config
   nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware-configuration.nix
   ```
   Replace `<hostname>` with `zaroc-4070`, `zaroc-gb3`, or `zaroc-server`.

4. **Install NixOS:**
   ```bash
   sudo nixos-install --flake .#<hostname>
   ```
   Replace `<hostname>` with your target system.

5. **Reboot and login as zaroc**

## Usage

### Rebuilding the system

```bash
# Rebuild and switch
sudo nixos-rebuild switch --flake .#<hostname>

# Test without switching boot default
sudo nixos-rebuild test --flake .#<hostname>

# Build only (don't activate)
sudo nixos-rebuild build --flake .#<hostname>
```

### Updating the system

```bash
# Update flake inputs
nix flake update

# Rebuild with updated inputs
sudo nixos-rebuild switch --flake .#<hostname>
```

## Customization

### Hardware Configuration

The hardware configuration files in `hosts/*/hardware-configuration.nix` should be regenerated for your actual hardware using:
```bash
nixos-generate-config --show-hardware-config
```

### User Configuration

Edit `home/zaroc.nix` to customize user-level settings, packages, and dotfiles.

### Common Settings

Edit `modules/common.nix` to change settings shared across all systems (timezone, locale, system packages, etc.).

## Features

### zaroc-4070 (NVIDIA Desktop)
- NVIDIA proprietary drivers with CUDA support
- KDE Plasma 6
- Hyprland window manager
- SDDM display manager

### zaroc-gb3 (Laptop)
- Intel CPU with integrated graphics
- Power management (TLP, auto-cpufreq)
- Touchpad support
- KDE Plasma 6
- Hyprland window manager
- SDDM display manager

### zaroc-server (AMD Server)
- AMD GPU with AMDGPU drivers
- ROCm support for compute workloads
- KDE Plasma 6
- Hyprland window manager
- SDDM display manager

## License

This is personal configuration. Feel free to use it as inspiration for your own setup.
