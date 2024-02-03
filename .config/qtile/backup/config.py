import os
import subprocess
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from qtile_extras.widget.decorations import RectDecoration
from colors import catppuccin

@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([script])

# Wallpaper changer:
def wallChanger(qtile):
    script = os.path.expanduser('~/.config/qtile/scripts/feh-randomize.sh')
    subprocess.call([script])

## My variables:
mod             = "mod1" #Default mod key ALT
sup             = "mod4" #Default mod key SUPER or WINDOWS
myTerminal      = "alacritty" #Default terminal
myBrowser       = "firefox" #Default browser
myBrave         = "brave-browser" # Brave browser
myFont          = "Iosevka Nerd Font Bold" # Default Font
myTitleFont     = "JetBrains Mono Bold" # Title Font
widgetFont      = "FontAwesome"
myFileManager   = "pcmanfm" # Default File Manager
myEditor        = "code" # Default Editor
myMusicPlayer   = "alacritty -e mocp" # Default Music Player
programLauncher = ["dmenu_run", "-fn", myFont, "-nb", catppuccin['bg'], "-nf", catppuccin['blue'], "-sb", catppuccin['green'], "-sf", catppuccin['bg']] # Run DMenu
volumeUp        = "pamixer -i 5" # Volume Up
volumeDown      = "pamixer -d 5" # Volume Down
volumeMute      = "pamixer --mute" # Mute
volumeUnmute    = "pamixer --unmute" # Unmute
rofiLauncher    = "rofi -show drun -show-icons" # Rofi Launcher
powerMenu       = "rofi -show session-menu -modi session-menu:~/.config/qtile/scripts/rofi-power-menu --choices=shutdown/reboot/logout/lockscreen" # Power Menu
mySpotify       = "brave-browser --app=https://open.spotify.com/" # Spotify 
myChatGPT       = "brave-browser --app=https://chat.openai.com" # ChatGPT

keys = [
    # My keys:
    Key([mod], "Return", lazy.spawn(myTerminal), desc="Launch terminal"),
    Key([sup], "f", lazy.spawn(myBrowser), desc="Open up the default browser"),
    Key([sup, "shift"], "f", lazy.spawn("firefox -p"), desc="Launch Firefox Profiles"),
    Key([mod], "d", lazy.spawn(myFileManager), desc="Open the default file manager"),
    Key([sup], "c", lazy.spawn(myEditor), desc="Launch VS Code"),
    Key([sup], "m", lazy.spawn(myMusicPlayer), desc="Launch Music Player"),
    Key([mod], "p", lazy.spawn(programLauncher), desc="Launch Dmenu"),
    Key([sup], "p", lazy.spawn(rofiLauncher), desc="Launch Rofi launcher!"),
    Key([sup], "r", lazy.spawn(powerMenu), desc="Launch Power Menu!"),
    Key([sup], "w", lazy.function(wallChanger), desc="Wallpaper changer!"),
    Key([sup], "b", lazy.spawn(myBrave), desc="Launch Brave browser!"),
    Key([sup], "m", lazy.spawn(mySpotify), desc="Launch Spotify!"),
    Key([sup], "g", lazy.spawn(myChatGPT), desc="Launch ChatGPT!"),

    # Volume keys:
    Key([mod], "F3", lazy.spawn(volumeUp), desc="Volume up!"),
    Key([mod], "F2", lazy.spawn(volumeDown), desc="Volume Down!"),
    Key([mod], "F4", lazy.spawn(volumeMute), desc="Mute!"),
    Key([mod], "F1", lazy.spawn(volumeUnmute),desc="Unmute!"),

    # Close window, shutdown and restart keys:
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Switch Window Focus:
    Key([sup], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([sup], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([sup], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([sup], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([sup], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    Key([sup, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([sup, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([sup, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([sup, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Window size changer
    Key(["control"], "Left", lazy.layout.shrink(), desc="Shrink left!"),
    Key(["control"], "Right", lazy.layout.grow(), desc="Grow Right!"),

    # Grow windows. If current window is on the edge of screen and direction
    Key([mod, "shift"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
]

## Workspaces:
groups = [
        Group('1', label="", layout='monadtall'),
        Group('2', label="", layout='monadtall', matches=[Match(wm_class=["Firefox-esr"])]),
        Group('3', label="󰨞", layout='monadtall', matches=[Match(wm_class=["code-oss"])]),
        Group('4', label="", layout='monadtall', matches=[Match(wm_class=["Pcmanfm"])]),
        Group('5', label="󰿎", layout='monadtall', matches=[Match(wm_class=["mpv"])]),
        ]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

## ScartchPads
groups.append(ScratchPad('scratchpad', [
    DropDown('term', 'alacritty',           width=0.5, height=0.5, x=0.2, y=0.2, opacity=1),
    DropDown('mocp', 'alacritty -e mocp',   width=0.5, height=0.5, x=0.2, y=0.2, opacity=1),
    DropDown('paco', 'pavucontrol',         width=0.4, height=0.6, x=0.3, y=0.1, opacity=1),
    DropDown('rang', 'alacritty -e ranger', width=0.5, height=0.5, x=0.2, y=0.2, opacity=1),
    ]))

# Keybinding for ScartchPads:
keys.extend([
    Key([sup], "1", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([sup], "2", lazy.group['scratchpad'].dropdown_toggle('mocp')),
    Key([sup], "3", lazy.group['scratchpad'].dropdown_toggle('paco')),
    Key([sup], "4", lazy.group['scratchpad'].dropdown_toggle('rang')),
])

## Window behaviour - Layouts:
layouts = [
    layout.MonadTall(
        border_focus=catppuccin['mauve'],
        border_normal=catppuccin['inactive'],
        margin=7
        ),
    layout.Max(),
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

## Default widgets settings:
widget_defaults = dict(
    font=myFont,
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

## Show only window name
def longNameParse(text): 
    for string in ["Chromium", "Firefox"]:
        if string in text:
            text = string
        else:
            text = text
    return text

## The bar:
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['bg_1'],
                    padding=10,
                    scale=0.55,
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/f_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                widget.GroupBox(
                    disable_drag=True,
                    active=catppuccin['mauve'],
                    inactive=catppuccin['maroon'],
                    highlight_method='text',
                    background=catppuccin['bg_1'],
                    spacing=5,
                    foreground=catppuccin['inactive'],
                    padding=3,
                    this_current_screen_border=catppuccin['green'],
                    fontsize=17
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/f_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                widget.WindowName(
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['rosewater'],
                    font=myTitleFont,
                    format="{name}",
                    max_chars=100,
                    empty_group_string="Desktop",
                    fontsize=12,
                    parse_text=longNameParse
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                # CPU
                widget.Image(
                    filename="~/.config/qtile/icons/cpu.png",
                    background=catppuccin['bg_1'],
                    margin_y=4,
                    ),
                widget.CPU(
                    format='{load_percent}%',
                    foreground=catppuccin['mauve'],
                    background=catppuccin['bg_1'],
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                        ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                        ),
                # Temperature
                widget.Image(
                    filename="~/.config/qtile/icons/temp.png",
                    background=catppuccin['bg_1'],
                    margin_y=4
                        ),
                widget.ThermalZone(
                    format='{temp}°C',
                    high=70,
                    crit=80,
                    fgcolor_crit=catppuccin['red'],
                    fgcolor_high=catppuccin['yellow'],
                    fgcolor_normal=catppuccin['blue'],
                    zone='/sys/class/thermal/thermal_zone0/temp',
                    update_interval=2,
                    background=catppuccin['bg_1'],
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                        ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                # RAM Memory
                widget.Image(
                    filename="~/.config/qtile/icons/ram.png",
                    background=catppuccin['bg_1'],
                    margin_y=4
                        ),
                widget.Memory(
                    format='{MemUsed:.0f}{mm}',
                    measure_mem='M',
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['green'],
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                # Sound
                widget.Image(
                    filename="~/.config/qtile/icons/sound.png",
                    background=catppuccin['bg_1'],
                    margin_y=4
                        ),
                widget.PulseVolume(
                    fmt='{:>4}',
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['yellow'],
                    update_interval=0.1,
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                # Date and Time
                widget.Image(
                    filename="~/.config/qtile/icons/time.png",
                    background=catppuccin['bg_1'],
                    margin_y=4
                        ),
                widget.Clock(
                    format='%H:%M',
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['peach'],
                    ),
                widget.Image(
                    filename="~/.config/qtile/icons/b_slash.png",
                    margin=-7
                    ),
                widget.Spacer(
                    length=-7,
                    background=catppuccin['bg_1']
                    ),
                # Date and Time
                widget.Image(
                    filename="~/.config/qtile/icons/date.png",
                    background=catppuccin['bg_1'],
                    margin_y=4
                        ),
                widget.Clock(
                    format='%e.%b',
                    background=catppuccin['bg_1'],
                    foreground=catppuccin['red'],
                    ),
                widget.Spacer(
                    length=7,
                    background=catppuccin['bg_1']
                    ),
                widget.Systray(
                    background=catppuccin['bg_1'],
                    iconsize=30,
                    ),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

## Default settings:
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=catppuccin['mauve'],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"

