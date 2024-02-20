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
    extraUpFlags = [ "--ssh" "--hostname" "basic" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443];

services.caddy = {
  enable = true;
  virtualHosts."example.org".extraConfig = ''
    encode gzip
    file_server
    root * ${
      pkgs.runCommand "testdir" {} ''
        mkdir "$out"
        echo hello world > "$out/index.html"
      ''
    }
  '';
}; 
networking.firewall.allowedTCPPorts = [ 80 443];
}
