{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Caddy service configuration.
  services.caddy = {
    enable = true;
    # Configure Caddy to serve a simple "Hello, world!" page.
    config = ''
      :80 {
        respond "Hello, world!"
      }
    '';
  };
}