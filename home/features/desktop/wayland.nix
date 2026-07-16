{
config,
lib,
pkgs,
...
}:

with lib;

let
cfg = config.features.desktop.wayland;
in
{
options.features.desktop.wayland.enable =
mkEnableOption "wayland extra tools and config";

config = mkIf cfg.enable {
programs.waybar = {
enable = true;

settings = {
mainBar = {
layer = "top";
position = "top";
height = 34;
spacing = 4;
margin-top = 6;
margin-left = 10;
margin-right = 10;

modules-left = [
"hyprland/workspaces"
"hyprland/window"
];

modules-center = [
"clock"
];

modules-right = [
"tray"
"pulseaudio"
"network"
"cpu"
"memory"
"temperature"
"battery"
];

"hyprland/workspaces" = {
format = "{icon}";
on-click = "activate";
sort-by-number = true;
format-icons = {
"1" = "一";
"2" = "二";
"3" = "三";
"4" = "四";
"5" = "五";
"urgent" = "";
"default" = "○";
};
};

"hyprland/window" = {
format = " {title}";
max-length = 48;
separate-outputs = true;
};

clock = {
format = "{:%H:%M}";
format-alt = "{:%a %d %b %H:%M}";
tooltip-format = "{calendar}";
calendar = {
mode = "year";
mode-mon-col = 3;
weeks-pos = "right";
on-scroll = 1;
format = {
months = "{}";
days = "{}";
weeks = "W{}";
weekdays = "{}";
today = "{}";
};
};
};

tray = {
icon-size = 16;
spacing = 8;
};

pulseaudio = {
format = "{icon} {volume}%";
format-muted = "󰝟 muted";
format-icons = {
default = [ "󰕿" "󰖀" "󰕾" ];
headphone = "󰋋";
};
on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
on-click-right = "pavucontrol";
scroll-step = 5;
tooltip = false;
};

network = {
format-wifi = " {essid}";
format-ethernet = " {ifname}";
format-disconnected = "󰤭 offline";
format-alt = "{ifname}: {ipaddr}/{cidr}";
tooltip-format = "{ifname} — {ipaddr}/{cidr}";
interval = 5;
};

cpu = {
format = " {usage}%";
interval = 2;
tooltip = false;
};

memory = {
format = " {percentage}%";
interval = 5;
tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
};

temperature = {
critical-threshold = 85;
format = "{icon} {temperatureC}°C";
format-critical = " {temperatureC}°C";
format-icons = [ "" "" "" ];
tooltip = false;
};

battery = {
states = {
good = 90;
warning = 30;
critical = 15;
};
format = "{icon} {capacity}%";
format-charging = "󰂄 {capacity}%";
format-plugged = " {capacity}%";
format-full = " full";
format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
tooltip-format = "{timeTo} · {power}W";
};
};
};

# GTK CSS — @keyframes is NOT supported; use transition instead
style = ''
* {
border: none;
border-radius: 0;
font-family: "JetBrainsMono Nerd Font", monospace;
font-size: 13px;
min-height: 0;
}

window#waybar {
background: rgba(17, 17, 27, 0.90);
border: 1px solid rgba(137, 180, 250, 0.12);
border-radius: 10px;
color: #cdd6f4;
}

.modules-left,
.modules-center,
.modules-right {
padding: 0 6px;
}

#workspaces,
#window,
#clock,
#tray,
#pulseaudio,
#network,
#cpu,
#memory,
#temperature,
#battery {
padding: 4px 10px;
margin: 4px 2px;
border-radius: 6px;
background: rgba(30, 30, 46, 0.70);
color: #cdd6f4;
transition: background 200ms ease, color 200ms ease;
}

#workspaces button {
padding: 0 6px;
border-radius: 4px;
color: #585b70;
background: transparent;
transition: color 150ms ease, background 150ms ease;
}

#workspaces button.active {
color: #89b4fa;
background: rgba(137, 180, 250, 0.12);
}

#workspaces button.urgent {
color: #f38ba8;
background: rgba(243, 139, 168, 0.12);
}

#workspaces button:hover {
color: #cdd6f4;
background: rgba(205, 214, 244, 0.08);
}

#window {
color: #7f849c;
font-style: italic;
}

#clock {
color: #89b4fa;
font-weight: 600;
letter-spacing: 0.04em;
background: rgba(137, 180, 250, 0.08);
}

#tray > .passive {
-gtk-icon-effect: dim;
}

#tray > .needs-attention {
background: rgba(243, 139, 168, 0.15);
}

#pulseaudio.muted {
color: #585b70;
}

#network.disconnected {
color: #585b70;
}

#cpu {
color: #a6e3a1;
}

#memory {
color: #94e2d5;
}

/* Critical states: solid color, no @keyframes needed */
#temperature.critical {
color: #f38ba8;
background: rgba(243, 139, 168, 0.18);
}

#battery.charging {
color: #a6e3a1;
}

#battery.warning:not(.charging) {
color: #fab387;
}

#battery.critical:not(.charging) {
color: #f38ba8;
background: rgba(243, 139, 168, 0.18);
}
'';
};
};
}
