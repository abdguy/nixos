{
    pkgs, 
    ...
}: {
    imports =[
        ./fish
        ./fzf.nix
               
    ];
   
    

    programs.bat = {enable = true;};

    home.packages = with pkgs; [
        coreutils
        fd
        htop
        httpie
        jq
        procs
        ripgrep
        tldr
        zip
    ];
}
