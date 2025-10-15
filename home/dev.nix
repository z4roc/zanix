{ config, pkgs, ... }:

{
  programs = with pkgs; [
    docker
    neovim
    vscode
    gcc
    gnumake
    python3
    nodejs
  ]
}