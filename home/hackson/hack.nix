# 1. Added 'lib' to the arguments so lib.lists.range works
{ config, lib, ... }: 

let
  # 2. Defined 'mod' so your workspace bindings know what key to use
  mod = "SUPER"; 
in
{ 
  imports = [ 
    ./home.nix 
    ../common  
    ./dotfiles
    ../features/cli 
    ../features/desktop
    ../features/cli/fish
  ]; 

  # Note: This will only work if you defined custom 'features' 
  # options in your other module files!
  features = {
    cli = {
      fish = {
        enable = true;
        #fzf.enable = true;
      };
       
    };
    desktop = {
      fonts.enable = true;
      hyprland.enable = true;
      wayland.enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    configType = "hyprlang";
    settings = {
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
        {
          name = "keyboard";
          kb_layout = "us";
        }
      ];
      
       monitor = ",preferred,auto,auto";

      # 3. FIXED: Assigned the mapped workspaces to the 'bind' list
      bind = [
        # You can add your normal bindings here too, for example:
        # "${mod}, Return, exec, kitty"
      ]
      ++ (map (i: "${mod}, ${toString (if i == 10 then 0 else i)}, workspace, ${toString i}") (lib.lists.range 1 10))
      ++ (map (i: "${mod} SHIFT, ${toString (if i == 10 then 0 else i)}, movetoworkspace, ${toString i}") (lib.lists.range 1 10));
    };
  }; # 4. FIXED: Added the missing semicolon here
}
