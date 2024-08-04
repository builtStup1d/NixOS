# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,inputs,lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
 
  #setting up home manager 
  home-manager = {
	extraSpecialArgs = {inherit inputs;};
	users = {
		"builtstupid" = import ./home.nix;
	};
  };

  #kernel 
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "builtstupid"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.builtstupid = {
    isNormalUser = true;
    description = "builtstupid";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Setting up steam
  programs.steam.enable = true; 
  programs.steam.gamescopeSession.enable = true; 
  programs.gamemode.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   python3
    python310
    git
    nh
    vim
    
    btop
    htop
    nvtop
    neofetch
    pciutils
    cudaPackages.cudatoolkit
    alsa-tools
   
    qbittorrent
    protonup-qt
    bottles
    vesktop
    gimp
    inkscape
    mpv
    easyeffects
    obsidian
    motrix
    protontricks
    floorp
    kdePackages.kdenlive
    ffmpeg
    ffmpegthumbnailer
    nautilus-python

    
    #hyprland stuff
    waybar
    dunst
    libnotify
    swww
    rofi-wayland
    kitty
    networkmanagerapplet

    #gnome extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.battery-health-charging
    gnomeExtensions.gpu-profile-selector
    gnomeExtensions.x11-gestures
    
    gnome.gnome-tweaks 
  ];

  environment.gnome.excludePackages = with pkgs.gnome; [
	epiphany totem yelp geary gnome-contacts gnome-maps pkgs.gnome-tour 
  ];

  #Enable openGL
  hardware.opengl = {
	enable = true;
  };
  
  #Setting up GPU
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;

 # hardware.nvidia.prime = {
 #       sync.enable = true;
 #       
 #       #itegrated 
 #       amdgpuBusId = "PCI:4:0:0";

 #       #dedicated 
 #       nvidiaBusId = "PCI:1:0:0";
 # };

  hardware.nvidia.prime = {
	offload = {
		enable = true;
		enableOffloadCmd = true;
	};

	#integrated 
	amdgpuBusId = "PCI:4:0:0";

	#dedicated
	nvidiaBusId = "PCI:1:0:0";
  };
  specialisation = {
	performance-mode.configuration = {
		hardware.nvidia = {
			prime.sync.enable = lib.mkForce true;
			prime.offload = {
				enable = lib.mkForce false;
				enableOffloadCmd = lib.mkForce false;
			};
		};
	};
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
  	enable = true;
	allowedTCPPortRanges = [
		{ from = 1714; to = 1764; }
	];
  	allowedUDPPortRanges = [
  		{ from = 1714; to = 1764; }
  	];
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  environment.sessionVariables = {
	FLAKE = "/etc/nixos/";
  };

}
