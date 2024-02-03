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
from keys import keys
from bar import screens
from layouts import layouts
import scratchpads
import workspaces

@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([script])

# Wallpaper changer:
def wallChanger(qtile):
    script = os.path.expanduser('~/.config/qtile/scripts/feh-randomize.sh')
    subprocess.call([script])

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

