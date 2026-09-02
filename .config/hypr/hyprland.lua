-- ~/.config/hypr/hyprland.lua
-- Converted from hyprlang (.conf) to Lua for Hyprland 0.55+
-- Source files: core/appearance, core/autostart, core/keybinds, core/env, core/windowrules
-- Reference: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- Environment & system sync
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")

    -- UI elements
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("awww-daemon")

    -- Authentication agent
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Theming & icons
    hl.exec_cmd("sleep 1 && hyprctl setcursor Bibata-Modern-Ice 20")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tokyonight-Dark-Cyan'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")

    -- Utilities
    hl.exec_cmd("pypr")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_SCALE", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("CHROME_CONFIG_FLAGS", "--password-store=gnome-libsecret")
hl.env("BROWSER", "/usr/bin/google-chrome-stable")


-----------------------
---- LOOK AND FEEL ----
-----------------------
-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 2,
        border_size  = 2,
        layout       = "master",
        allow_tearing = false,

        col = {
            active_border   = { colors = { "rgb(89b4fa)", "rgb(a6e3a1)" }, angle = 45 },
            inactive_border = "rgb(313244)",
        },
    },

    decoration = {
        rounding         = 6,
        active_opacity   = 1.0,
        inactive_opacity = 0.9,
        dim_inactive     = true,
        dim_strength     = 0.1,

        blur = {
            enabled            = true,
            size               = 8,
            passes             = 3,
            new_optimizations  = true,
            special            = true,
            xray               = true,
        },

        shadow = {
            enabled        = true,
            range          = 15,
            render_power   = 3,
            color          = "rgba(1a1a1aee)",
            color_inactive = "rgba(00000000)",
        },
    },

    animations = {
        enabled = true,
    },
})

-- Bezier curves & animation config, converted from:
--   bezier = snap, 0.05, 0.9, 0.1, 1.1
--   animation = <name>, <onoff>, <speed>, snap, <style>
hl.curve("snap", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 3, bezier = "snap",    style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snap",    style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "snap",    style = "slidevert" })

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        orientation = "left",
        mfact       = 0.5,
        new_on_top  = true,
    },
})

----------------
----  MISC  ----
----------------
hl.config({
    misc = {
        force_default_wallpaper   = 0,
        disable_hyprland_logo     = true,
        disable_splash_rendering  = true,
    },

    xwayland = {
        force_zero_scaling = true, -- Set false if on 4K or mixed DPI
    },
})


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout          = "us",
        follow_mouse       = 1,
        numlock_by_default = true,
        sensitivity        = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

-- Window Management
hl.bind("ALT + RETURN",     hl.dsp.exec_cmd("kitty"))
hl.bind("ALT + SHIFT + C",  hl.dsp.window.close())
hl.bind("ALT + SHIFT + Q",  hl.dsp.exit())
hl.bind("ALT + F",          hl.dsp.window.float({ action = "toggle" }))

-- Launcher & Menus
hl.bind("ALT + SPACE",   hl.dsp.exec_cmd("rofi -show drun"))
-- hl.bind("ALT + SPACE", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("wlogout"))

-- Browsers & Productivity
hl.bind("SUPER + F",         hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("firefox -p"))
hl.bind("SUPER + Z",         hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("zen-browser -p"))
hl.bind("SUPER + B",         hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind("SUPER + C",         hl.dsp.exec_cmd("code"))
hl.bind("SUPER + O",         hl.dsp.exec_cmd("obs"))
hl.bind("ALT + D",           hl.dsp.exec_cmd("thunar"))

-- Media & Gaming
hl.bind("ALT + G",   hl.dsp.exec_cmd("steam"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("~/.config/waybar/theme.sh"))
hl.bind("ALT + J",   hl.dsp.exec_cmd("flatpak run org.jellyfin.JellyfinDesktop"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/screenshot_$(date '+%Y-%m-%d_%H-%M-%S').png"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("prismlauncher"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("rofimoji --selector rofi --action copy")) -- change to wofi if needed

-- System & Scripts
hl.bind("ALT + L",         hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + W",       hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wall-selector.sh"))
hl.bind("ALT + SHIFT + R", hl.dsp.exec_cmd("~/.config/waybar/start.sh"))
hl.bind("SUPER + H", hl.dsp.exec_cmd("kitty --title hypr-cheatsheet bash -lc '/usr/bin/glow -p ~/.config/hypr/scripts/hyprland_cheat_sheet.md'"))
hl.bind("ALT + H",   hl.dsp.exec_cmd("kitty --title hypr-cheatsheet bash -lc '/usr/bin/glow -p ~/.config/hypr/scripts/hyprland_cheat_sheet_keybindings_en.md'"))

-- Scratchpads (Pyprland)
hl.bind("SUPER + 1",       hl.dsp.exec_cmd("pypr toggle term"))
hl.bind("SUPER + 2",       hl.dsp.exec_cmd("pypr toggle bitwarden"))
hl.bind("ALT + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Master Layout & Resize
hl.bind("SUPER + RIGHT",       hl.dsp.layout("cyclenext"))
hl.bind("SUPER + LEFT",        hl.dsp.layout("cycleprev"))
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.layout("swapwithmaster"))
hl.bind("ALT + SHIFT + LEFT",  hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("ALT + SHIFT + RIGHT", hl.dsp.window.resize({ x = 20,  y = 0, relative = true }))

-- Audio Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Focus Movement
hl.bind("ALT + left",  hl.dsp.focus({ direction = "l" }))
hl.bind("ALT + right", hl.dsp.focus({ direction = "r" }))
hl.bind("ALT + up",    hl.dsp.focus({ direction = "u" }))
hl.bind("ALT + down",  hl.dsp.focus({ direction = "d" }))

-- Workspace Navigation (ALT + 1-9,0) & Move Window to Workspace (ALT + SHIFT + 1-9,0)
-- 0 maps to workspace 10, same as the original conf
for i = 1, 10 do
    local key = i % 10
    hl.bind("ALT + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind("ALT + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Mouse Bindings
hl.bind("ALT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind("ALT + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind("ALT + mouse:273",  hl.dsp.window.resize(), { mouse = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- ── Workspace Assignments ─────────────────────────────

-- Browser Workspaces
hl.window_rule({ match = { class = "^([Zz]en)$" },              workspace = 2 })
hl.window_rule({ match = { class = "^([Bb]rave-browser)$" },    workspace = 2 })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome)$" },    workspace = 2 })
hl.window_rule({ match = { class = "^([Tt]horium-browser)$" },  workspace = 2 })
hl.window_rule({ match = { class = "^([Vv]ivaldi-stable)$" },   workspace = 2 })

-- Development
hl.window_rule({ match = { class = "^([Cc]ode)$" },  workspace = 3 })
hl.window_rule({ match = { class = "^([Ee]macs)$" }, workspace = 3 })

-- File Management
hl.window_rule({ match = { class = "^([Tt]hunar)$" }, workspace = 4 })

-- Media & Production
hl.window_rule({ match = { class = "^(.*obsproject.Studio*)$" }, workspace = 6 })
hl.window_rule({ match = { class = "^([Dd]iscord)$" },           workspace = 8 })

-- Gaming
hl.window_rule({ match = { class = "^([Ss]team)$" },                       workspace = 7 })
hl.window_rule({ match = { class = "^(.*prismlauncher.PrismLauncher*)$" }, workspace = 7 })

-- ── Floating Windows ──────────────────────────────────

-- Steam
hl.window_rule({ match = { title = "^(Steam - Self Updater)$" }, float = true, center = true })
hl.window_rule({ match = { title = "^(Friends List)$" },         float = true, size = "400 700", center = true })
hl.window_rule({ match = { class = "^(steamwebhelper)$" },       float = true, center = true })

-- Pavucontrol
hl.window_rule({ match = { class = "(.*org.pulseaudio.pavucontrol.*)" }, float = true, size = "700 600", center = true })

-- Wallpaper Picker
hl.window_rule({ match = { title = "^(wallpaper-picker)$" }, float = true, size = "1000 600", center = true })

-- Bitwarden
hl.window_rule({ match = { title = "^(Bitwarden)$" }, float = true, size = "1000 600", center = true })

-- Topgrade
hl.window_rule({ match = { class = "^(topgrade)$" }, float = true, size = "800 600", center = true })
