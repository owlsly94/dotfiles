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

# Keys:
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

