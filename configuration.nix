{ config, pkgs, ... }:
let 
#  flakeryDomain = 
# read /metdata/flakery-domain
  flakeryDomain = builtins.readFile /metdata/flakery-domain;
in
{
  system.stateVersion = "23.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
 };

  # allow alice to run sudo without password
  security.sudo.wheelNeedsPassword = false;


  services.tailscale = {
    enable = true;
    authKeyFile = "/tsauthkey";
    extraUpFlags = [ "--ssh" "--hostname" "basic" ];
  };




  services.caddy = {
    enable = true;
    virtualHosts."${flakeryDomain}".extraConfig = ''
      respond "Hello, world!"
    '';
  }; 
  networking.firewall.allowedTCPPorts = [ 80 443];
}
