{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Caddy service configuration.
  services.caddy = {
    enable = true;
    extraConfig = ''
      0.0.0.0
      
      respond "Hello, world!"
    '';
  };
}