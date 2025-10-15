# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
  networking.hostName = "zaroc-4070";

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  
  services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  
  services.libinput.enable = true;

  users.users.zaroc = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
       tree
     ];
   };
  services.getty.autologinUser = "zaroc";
  

  # KDE Plasma Desktop
  services.xserver = {
	  enable = true;
	  displayManager.sddm.enable = true;
	  desktopManager.plasma6.enable = true;
	  displayManager.autoLogin.enable = true;
	  displayManager.autoLogin.user = "zaroc";
  };


  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
     vim 
     wget
     kitty
     foot
     waybar
     git
     hyprpaper
  ];


  system.stateVersion = "25.05";

}

