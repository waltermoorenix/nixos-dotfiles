
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixosbtw"; 


  networking.networkmanager.enable = true;


  time.timeZone = "Europe/Lisbon";


  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

 
  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nixos-dotfiles/walls/wall1.png
    '';
    extraConfig = ''
      	Section "Monitor"
      	  Identifier "Virtual-1"
      	  Option "PreferredMode" "1920x1080"
      	EndSection
    '';
  };

  services.picom.enable = true;
  
  services.desktopManager.budgie.enable = true;


  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

 
  console.keyMap = "pt-latin1";


  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  users.users."vito" = {
    isNormalUser = true;
    description = "vito";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
       tree
    ];
  };

 
  programs.firefox.enable = true;

  
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    vim 
    wget
    alacritty
    git
  ];

   fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";

}
