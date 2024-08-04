{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "builtstupid";
  home.homeDirectory = "/home/builtstupid";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  #allow unfree
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
#	btop
#        htop
#	nvtop
#	neofetch
#	pciutils
#	cudaPackages.cudatoolkit
#	alsa-tools
#
#	python3
#	python310
#	git
#	nh
#	vim
#
#	qbittorrent
#	protonup-qt
#	bottles
#	vesktop
#	gimp 
#	inkscape
#	mpv
#	easyeffects
#	obsidian 	
#	motrix
#	protontricks
#
#	#hyprland stuff
#	waybar
#	dunst
#	libnotify
#	swww
#	rofi-wayland
#	kitty
#	networkmanagerapplet
#
#	#gnome extensions
#	gnomeExtensions.blur-my-shell
#    	gnomeExtensions.just-perfection
#    	gnomeExtensions.tray-icons-reloaded
#    	gnomeExtensions.vitals
#    	gnomeExtensions.clipboard-indicator
#    	gnomeExtensions.gsconnect
#    	gnomeExtensions.battery-health-charging
#	gnomeExtensions.gpu-profile-selector
#    	
#    	gnome.gnome-tweaks
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/builtstupid/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
