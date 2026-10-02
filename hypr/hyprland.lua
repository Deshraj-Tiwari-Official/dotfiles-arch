-- External Config Includes & Startup

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function ()
  hl.exec_cmd("paplay ~/.config/hypr/config.d/sounds/Windows_11.wav")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("hyprctl setcursor Banana-Dracula 64")
  hl.exec_cmd("waybar")
  hl.exec_cmd("copyq --start-server")
  hl.exec_cmd("dunst")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("syncthing --no-browser")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")
end)

-- Default Applications & Variables

local terminal = "wezterm start --always-new-process"
local browser  = "zen-browser"
local mod      = "SUPER"

-- Look and Feel

hl.config({
    general = {
        gaps_in          = 3,
        gaps_out         = 9,
        ["col.active_border"]   = "rgba(a6a6a6dd)",
        ["col.inactive_border"] = "rgba(222222bb)",
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.82,
        fullscreen_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.12,
        dim_special = 0.35,
        blur = {
            enabled = true,
            size = 3,
            passes = 3,
            new_optimizations = true,
            xray = false,
            ignore_opacity = true,
            noise = 0.02,
            contrast = 0.97,
            brightness = 0.75,
            vibrancy = 0.22,
            vibrancy_darkness = 0.1,
            special = false,
            popups = true,
            popups_ignorealpha = 0.2,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    animations = {
        enabled = true,
    },
})

-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { {0.25, 0.9}, {0.3, 1.0} } })

-- Animations
hl.animation({ leaf = "windows",     enabled = true, speed = 2, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2, bezier = "default" })

-- Input Devices & Peripherals

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "caps:swapescape",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
            scroll_factor  = 1.5,
        },
    },
})

-- Device-specific settings
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- Application & Launcher Keybinds

-- Menu & Apps
hl.bind("ALT + space", hl.dsp.exec_cmd("~/dotfiles/00_scripts/rofi_appmenu.sh"))
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B",      hl.dsp.exec_cmd(browser))

-- Custom Utilities & Scripts
hl.bind(mod .. " + Y", hl.dsp.exec_cmd("~/dotfiles/00_scripts/rofi_keybinds.sh"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("~/dotfiles/00_scripts/themeswitcher.sh"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("~/dotfiles/00_scripts/rofi_themeswitcher.sh"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("~/dotfiles/00_scripts/rofi_powermenu.sh"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("~/dotfiles/00_scripts/hyprsunset_toggle.sh"))

-- Screenshots and Color Picker
hl.bind(mod .. " + F1",       hl.dsp.exec_cmd("~/dotfiles/00_scripts/ss_copy.sh"))
hl.bind(mod .. " + ALT + F1", hl.dsp.exec_cmd("~/dotfiles/00_scripts/ss_save.sh"))
hl.bind(mod .. " + F2",       hl.dsp.exec_cmd("hyprpicker"))

-- Layout / Fullscreen Toggles
hl.bind(mod .. " + F11", hl.dsp.exec_cmd("~/dotfiles/00_scripts/enter_fullscreen.sh"))
hl.bind(mod .. " + F12", hl.dsp.exec_cmd("~/dotfiles/00_scripts/exit_fullscreen.sh"))

-- Window & Focus Management

hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd("~/dotfiles/00_scripts/hyprlock_wallpaper.sh"))

-- Vim-style focus movement
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspaces & Navigation

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10 -- 10 maps to 0
    hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspace mouse scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Drag / resize windows with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Hardware & Media Controls

-- Audio / Brightness (repeating = true and locked = true emulate 'bindel')
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

-- Media keys (locked = true emulates 'bindl')
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Window Rules

hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Float kitty automatically
hl.window_rule({
    name   = "float-kitty",
    match  = { class = "^(kitty)$" },
    float  = true,
    center = true,             -- Centers kitty on the screen
    size   = { 900, 600 },     -- Optional: sets width and height in pixels
})
