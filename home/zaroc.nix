{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.illogical-impulse.homeManagerModules.default
  ];

  home.username = "zaroc";
  home.homeDirectory = "/home/zaroc";

  # Home Manager state version
  home.stateVersion = "25.05";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "zaroc";
    userEmail = "arthuraktamirov@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake /home/zaroc/zanix";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake /home/zaroc/zanix";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" ];
    };
  };

  # Terminal emulator configuration (Kitty)
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
    theme = "Dracula";
    settings = {
      background_opacity = "0.6";
      confirm_os_window_close = 0;
    };
  };

  # VSCode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      bbenoist.nix
    ];
  };

  # Home packages
  home.packages = with pkgs; [
    
    # Desktop apps
    vesktop
    spotify
    vlc    

    # CLI tools
    btop
    ripgrep
    fd
    eza
    bat
    fzf
    
    # Fonts
    jetbrains-mono
    # nerdfonts DEPRECATED
  ];

  # XDG configuration
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
  };
}
