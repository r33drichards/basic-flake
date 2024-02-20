{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Caddy service configuration.
  services.caddy = {
    enable = true;
  };
}