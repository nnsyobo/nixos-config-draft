{ config, pkgs, lib, home-manager, user, ... }:
  let user = "alice";
in {
  imports = [
    # ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    masApps = {
      "wireguard" = 1451685025;
      "xcode" = 497799835;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        # packages = pkgs.callPackage ./packages.nix {};
        # file = lib.mkMerge [
        #   sharedFiles
        #   additionalFiles
        # ];
        stateVersion = "24.05";
      };
      # programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };
    };
  };

  # Fully declarative dock using the latest from Nix Store
  # local.dock.enable = true;
  # local.dock.entries = [
  #   { path = "/Applications/Slack.app/"; }
  #   { path = "/System/Applications/Messages.app/"; }
  #   { path = "/System/Applications/Facetime.app/"; }
  #   { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
  #   { path = "/System/Applications/Music.app/"; }
  #   { path = "/System/Applications/News.app/"; }
  #   { path = "/System/Applications/Photos.app/"; }
  #   { path = "/System/Applications/Photo Booth.app/"; }
  #   { path = "/System/Applications/TV.app/"; }
  #   { path = "/System/Applications/Home.app/"; }
  #   {
  #     path = toString myEmacsLauncher;
  #     section = "others";
  #   }
  #   {
  #     path = "${config.users.users.${user}.home}/.local/share/";
  #     section = "others";
  #     options = "--sort name --view grid --display folder";
  #   }
  #   {
  #     path = "${config.users.users.${user}.home}/.local/share/downloads";
  #     section = "others";
  #     options = "--sort name --view grid --display stack";
  #   }
  # ];

}
