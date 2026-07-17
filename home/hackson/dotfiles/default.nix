{
    inputs, 
    ...
}:{
    imports = [
        ./bat.nix
    ];
    home.file.".config/nano" = {
        source = "${inputs.dotfiles}";
        recursive = true;
    };
}