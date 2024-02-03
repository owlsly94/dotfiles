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

