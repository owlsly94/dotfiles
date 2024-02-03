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


