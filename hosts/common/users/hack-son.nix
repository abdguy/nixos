{
    config,
    pkgs,
    inputs,
    ...
}: {
    
    users.users.hackson = {
        initialHashedPassword = "$y$j9T$/z8CMzp88TXh7NQi.zDIX1$NPzBNrTHX7SxscsS8OkEtbdnWhyqLP83NUuAZaSJ2X";
    isNormalUser = true;
    description = "hackson";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "flatpak" "audio" "video" "plugdev" "input" "kvm" "qemu-libvirtd"];

    openssh.authorizedKeys.keys= [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuoT5h3yBTWIh83FHJ1qUJpvmUCNb5tNQJ+bTagfdwP hack@nixos"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];

    };
   home-manager.users.hackson = import ../../../home/hackson/hack.nix;
}
