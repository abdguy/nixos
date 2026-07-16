{
    config,
    lib,
    pkgs,
    ...

}:
with lib; let
    cfg = config.features.cli.fzf;
in{
        options.features.cli.fzf.enable = mkEnableOption "enable fuzzy finder";

        config = mkIf cfg.enable{
            
           
            programs.fzf ={
                enable = true;
                enableFishIntegration = true;
                
              
                colors = {
               "bg" = "#1e1e2e";
               "bg+" = "#313244";
               "fg" = "#cdd6f4";
                "fg+" = "#cdd6f4";
               "hl" = "#f38ba8";
                "hl+" = "#f38ba8";
                "info" = "#cba6f7";
                "marker" = "#f5e0dc";
                "prompt" = "#cba6f7";
                "pointer" = "#f5e0dc";

  };

              defaultOptions = [
                "--preview 'bat --color=always -n {}'"
                "--bind 'ctrl-/:toggle-preview'"
];
               defaultCommand = "fd --type f --exclude .git --follow --hidden";
               changeDirWidget.command = "fd --type d --exclude .git --follow --hidden";

    };


   };
  }

 
