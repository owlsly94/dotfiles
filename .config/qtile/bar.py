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
            margin = 5,
        ),
    ),
]

