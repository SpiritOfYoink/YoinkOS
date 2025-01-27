# Inputs possible because of the specialArgs line in flake.nix forwarding inputs:
{ pkgs, config, lib, inputs, variables, ... }: with lib; {


#   ..... MODULES .....
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./home-manager.nix
    ];


#   ..... BOILERPLATE .....
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    nix.settings.experimental-features = ["nix-command flakes"];
    nix.checkConfig = true;
    nix.checkAllErrors = true;

    environment.systemPackages = with pkgs; [
      git   # Flakes clones its dependencies through the git command, so it must be at the top of the list.
      home-manager
      ];

    networking.hostName = "${networking-hostname}";    # What the computer is called on your network.
    system.stateVersion = "24.11";    # Only change this if you're on a fresh install of a newer version of NixOS.
    time.timeZone = "America/Los_Angeles";      # Sets your time zone.
    i18n.defaultLocale = "en_US.UTF-8";     # Selects internationalisation properties.
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
        };


#   ..... CONFIG .....
    users.users.yoink = {
      isNormalUser = true;
      description = "${fullname}";
      extraGroups = [ "wheel"  "networkmanager"];
      initialPassword = "12345";    # TODO: Be sure to change this to the secrets below, when you get that set up.
      # HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/user-secrets" };   # This is the user's password.
      # HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/root-secrets"; };   # This is the root user's password.
      };

    nvidia-drivers.enable = true; 


#   ..... NETWORKED STORAGE .....

    services.gvfs.enable = true;    # Enables the GVFS daemon to allow GTK file-managers access to brouse samba shares.

      fileSystems."/mnt/nas-storage" = {
        device = "${server}";   # The target to connect to.
        fsType = "cifs";
        options = [
          "credentials=/home/${user}/hosts/${user}/secrets/smb-secrets"
          "x-systemd.automount"
          "x-systemd.requires=network-online.target"    # If you have issues because the target isn't there, remove this line and the next.
          "x-systemd.after=network-online.target"
          "x-systemd.idle-timeout=60"
          "x-systemd.device-timeout=5s"
          "x-systemd.mount-timeout=5s,"   # These lines prevent the system hanging if the target fails to reply.
          "rw" "uid=${user}" "gid=1000"    # Sends the user's name and group.
          "vers=3.02"
            ]; };


}