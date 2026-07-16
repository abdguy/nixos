{
    pkgs,
    ...
}:{
    imports = [
         ./hyprland.nix
        ./wayland.nix
    ];
    home.packages = with pkgs;[

    ];

}
