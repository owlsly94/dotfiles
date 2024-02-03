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
from variables import mod, sup, myTerminal, myBrowser, myBrave, myFont, myTitleFont, widgetFont, myFileManager, myEditor, \
        myMusicPlayer, programLauncher, volumeUp, volumeDown, volumeMute, volumeUnmute, rofiLauncher, powerMenu, mySpotify, myChatGPT

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


