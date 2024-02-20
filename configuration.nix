{ config, pkgs, ... }:
let 
  flakeryDomain = builtins.readFile /metadata/flakery-domain;
in
{
  system.stateVersion = "23.05";

  services.caddy = {
    enable = true;
    virtualHosts."${flakeryDomain}".extraConfig = ''
      respond "Hello, world!"
    '';
  }; 
  networking.firewall.allowedTCPPorts = [ 80 443];
}
