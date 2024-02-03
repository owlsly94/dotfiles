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

