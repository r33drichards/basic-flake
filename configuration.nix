{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.caddy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  # Caddy service configuration.
  services.caddy = {
    enable = true;
    user = "caddy";
    # Configure Caddy to serve a simple "Hello, world!" page.
    config = ''
      :80 {
        respond "Hello, world!"
      }
    '';
  };
}