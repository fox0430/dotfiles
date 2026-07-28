---- MONITORS ----

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "DP-3", mode = "2560x1440", position = "0x300", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "3840x2160", position = "2560x0", scale = 1 })

hl.monitor({ output = "DP-3", mode = "3840x2160", position = "-2160x-650", scale = 1, transform = 1 })
hl.monitor({ output = "DP-1", mode = "3840x2160", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "3840x2160", position = "3840x0", scale = 1 })


---- WORKSPACES ---

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, on_created_empty = "kitty" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3" })


---- MY PROGRAMS ----

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"


---- AUTOSTART ----

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE" ..
        " && systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service")
    hl.exec_cmd("hyprpaper & waybar & fcitx5")
end)

-- These ran on every config (re)load with the old `exec =` keyword
local function applyGtkTheme()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Nordic"')      -- for GTK3 apps
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps
end

hl.on("config.reloaded", applyGtkTheme)


---- ENVIRONMENT VARIABLES ----

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- for Qt apps
hl.env("XCURSOR_SIZE", "24")


-- Split this configuration into multiple files by requiring them, e.g.:
-- require("myColors")


---- LOOK AND FEEL ----

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in     = 15,
        gaps_out    = 20,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        layout = "master",

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
    },

    decoration = {
        rounding = 10,

        blur = {
            enabled = true,
            size    = 3,
            passes  = 2,
        },

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
    },

    animations = {
        enabled = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/ for more
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })


---- LAYOUTS ----

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        mfact          = 0.75,
        smart_resizing = false,
        orientation    = "top",
        new_on_top     = true,
    },
})

----  MISC  ----

hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 to disable the anime mascot wallpapers
    },
})

---- INPUT ----

-- For all categories, see https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---- WINDOWS AND WORKSPACES ----

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Set floating window size
-- hl.window_rule({
--     name  = "ghostty-size",
--     match = { class = "^(ghostty)$" },
--     size  = "50% 50%",
-- })


---- KEYBINDINGS ----

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local mainMod      = "SUPER"
local mainModShift = "SUPER + SHIFT"

hl.bind(mainMod .. " + return",      hl.dsp.exec_cmd(terminal))
hl.bind(mainModShift .. " + return", hl.dsp.exec_cmd("kitty", { float = true }))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",           hl.dsp.exec_cmd("vivaldi-snapshot"))
hl.bind(mainMod .. " + R",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",           hl.dsp.exec_cmd("wofi -G --show drun"))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.bind(mainModShift .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainModShift .. " + C", hl.dsp.window.close())
hl.bind(mainModShift .. " + Q", hl.dsp.exit())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,      hl.dsp.focus({ workspace = i }))
    hl.bind(mainModShift .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",      hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainModShift .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cycle focus
hl.bind(mainMod .. " + j", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + k", hl.dsp.window.cycle_next({ next = false }))

-- Resize the active window
-- NOTE: key names are matched case-insensitively, so these must NOT share the
-- SUPER-only modmask with the cycle binds above, or both would fire at once.
hl.bind(mainModShift .. " + L", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }))
hl.bind(mainModShift .. " + H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }))
hl.bind(mainModShift .. " + K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }))
hl.bind(mainModShift .. " + J", hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }))

hl.bind(mainMod .. " + m", hl.dsp.window.float({ action = "toggle" }))
