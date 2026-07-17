{pkgs,lib,config, ...}:

with lib; let
    cfg = config.extraservices.podman;
    in{
        options.extraservices.podman.enable = mkEnableOption "enable extended podman configuration";

        config = mkIf cfg.enable{

    virtualisation = {
        podman = {
            enable = true;
            dockerCompat = true;
            autoPrune = {
                enable = true;
                dates = "weekly";
                flags = [
                    "--filter=until=24h"
                    "--filter=label!=important"
                ];
            };
            defaultNetwork.settings.dns_enabled = true;
        };
    };
    environment.systemPackages = with pkgs; [
        podman-compose
    ];
};
    }