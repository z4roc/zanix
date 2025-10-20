{ inputs, config, pkgs, ... }:

{
    home.username = "zaroc";
    home.homeDirectory = "/home/zaroc";

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
}