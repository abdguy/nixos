{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.features.desktop.hyprland;
  mod = "SUPER";
in
{
  options.features.desktop.hyprland.enable =
    mkEnableOption "wayland extra tools and config";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = ",preferred,auto,auto";

        env = [
          "WLR_RENDERER_ALLOW_SOFTWARE,1"
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
        ];

        "exec-once" = [
          "waybar"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 10;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(00000099)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 2;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
          ];

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

 "dwindle:preserve_split" = true;

gesture = [
  "3, horizontal, workspace"
];

"master" = {
  new_status = "master";
};



        misc = {
          force_default_wallpaper = -1;
        };

        bindl = [
          # Volume controls (using wpctl is more reliable on NixOS/PipeWire)
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          
          # Brightness controls
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ];

        bind = [
          "${mod}, Q, exec, kitty"
          "${mod}, C, killactive"
          "${mod}, M, exit"
          "${mod}, E, exec, dolphin"
          "${mod}, V, togglefloating"
          "${mod}, R, exec, wofi --show drun"
          "${mod}, P, pseudo"
          "${mod}, J, layoutmsg, togglesplit"
          "${mod}, left, movefocus, l"
          "${mod}, right, movefocus, r"
          "${mod}, up, movefocus, u"
          "${mod}, down, movefocus, d"
          
          "${mod}, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
          "${mod}, S, togglespecialworkspace, magic"
          "${mod} SHIFT, S, movetoworkspace, special:magic"
          "${mod}, mouse_down, workspace, e+1"
          "${mod}, mouse_up, workspace, e-1"
        ]
        ++ (map (i: "${mod}, ${toString (if i == 10 then 0 else i)}, workspace, ${toString i}") (lib.lists.range 1 10))
        ++ (map (i: "${mod} SHIFT, ${toString (if i == 10 then 0 else i)}, movetoworkspace, ${toString i}") (lib.lists.range 1 10));

        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];
      

    extraConfig = ''
  windowrule = suppressevent maximize, class:.*
'';
      };
    };
  };
}