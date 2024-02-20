{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    # set shell to zsh 
    # passwordFile = "/persist/passwords/alice";
  };

  # allow alice to run sudo without password
  security.sudo.wheelNeedsPassword = false;


  services.tailscale = {
    enable = true;
    authKeyFile = "/tsauthkey";
    extraUpFlags = ["--ssh" "--hostname" "basic"];
  };

  # Caddy service configuration.
  services.caddy = {
    enable = true;
    extraConfig =  ''
    localhost {
      respond "Hello world"
    }
    '';
  };
}