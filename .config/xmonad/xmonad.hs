-----------------------------
---------- IMPORTS ----------
-----------------------------

import System.IO
import System.Exit
import XMonad

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Hooks.InsertPosition

-- Utils
import XMonad.Util.Run (spawnPipe, hPutStrLn)
import XMonad.Actions.SpawnOn
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Actions.CycleWS
import XMonad.Actions.WithAll
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedScratchpad

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-----------------------------
---------- COLORS -----------
-----------------------------
-- TokyoNight Storm palette
tnBg        :: String
tnBgDark    :: String
tnBgHL      :: String
tnFg        :: String
tnComment   :: String
tnBlue      :: String
tnCyan      :: String
tnPurple    :: String
tnGreen     :: String
tnOrange    :: String
tnRed       :: String

tnBg        = "#24283b"   -- background
tnBgDark    = "#1f2335"   -- darker background
tnBgHL      = "#292e42"   -- highlight background
tnFg        = "#c0caf5"   -- foreground
tnComment   = "#565f89"   -- comments / dim
tnBlue      = "#7aa2f7"   -- blue
tnCyan      = "#7dcfff"   -- cyan
tnPurple    = "#bb9af7"   -- purple
tnGreen     = "#9ece6a"   -- green
tnOrange    = "#ff9e64"   -- orange
tnRed       = "#f7768e"   -- red

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = tnComment
myFocusedBorderColor = tnBlue

-----------------------------
---------- MODKEY -----------
-----------------------------
myModMask :: KeyMask
myModMask = mod1Mask

-----------------------------
--------- TERMINAL ----------
-----------------------------
myTerminal :: String
myTerminal = "kitty"

-----------------------------
----- SECOND TERMINAL -------
-----------------------------
mySecondTerminal :: String
mySecondTerminal = "alacritty"

-----------------------------
---------- BROWSER ----------
-----------------------------
myBrowser, myFirefox :: String
myBrowser = "zen-browser"
myFirefox = "firefox"

-----------------------------
------- FILE MANAGER --------
-----------------------------
myFileManager :: String
myFileManager = "thunar"

-----------------------------
------ STEAM LAUNCHER -------
-----------------------------
mySteamLauncher :: String
mySteamLauncher = "steam"

-----------------------------
---------- EDITORS ----------
-----------------------------
myWorkEditor, myEditor :: String
myWorkEditor = "code"
myEditor     = myTerminal ++ " -e nvim"

-----------------------------
------ VOLUME CONTROL -------
-----------------------------
volumeUp, volumeDown, volumeMute :: String
volumeUp   = "pamixer -i 5"
volumeDown = "pamixer -d 5"
volumeMute = "pamixer --toggle-mute"

-----------------------------
--------- LAUNCHERS ---------
-----------------------------
rofiLauncher :: String
rofiLauncher = "rofi -show drun -show-icons"

-----------------------------
-------- POWER MENU ---------
-----------------------------
powerMenu :: String
powerMenu = "rofi -show session-menu -modi session-menu:~/.config/xmonad/scripts/rofi-power-menu --choices=shutdown/reboot/logout/lockscreen"

-----------------------------
--- RESTART AND RECOMPILE ---
-----------------------------
myRecompileRestart :: String
myRecompileRestart = "xmonad --recompile && xmonad --restart"

-----------------------------
------- WALL CHANGER --------
-----------------------------
wallChanger :: String
wallChanger = "$HOME/.config/xmonad/scripts/feh-randomize.sh"

-----------------------------
-------- MOUSE FOCUS --------
-----------------------------
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-----------------------------
------- BORDER WIDTH --------
-----------------------------
myBorderWidth :: Dimension
myBorderWidth = 2

-----------------------------
------- MAIN CONFIG ---------
-----------------------------
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmonad/xmobar/xmobar.hs"
    xmonad . docks . ewmhFullscreen . ewmh $ myConfig xmproc

myConfig xmproc = def
    { startupHook        = myStartupHook
    , layoutHook         = myLayout
    , manageHook         = insertPosition End Newer <+> manageSpawn <+> myManageHook <+> manageHook def
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , handleEventHook    = handleEventHook def
    , focusFollowsMouse  = myFocusFollowsMouse
    , workspaces         = myWorkspaces
    , focusedBorderColor = myFocusedBorderColor
    , normalBorderColor  = myNormalBorderColor
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , logHook            = dynamicLogWithPP myXmobarPP
        { ppOutput       = hPutStrLn xmproc }
    } `additionalKeysP` myAditionalKeys

-----------------------------
--------- AUTOSTART ---------
-----------------------------
myStartupHook :: X ()
myStartupHook = do
    spawn     "killall dunst"
    spawnOnce "~/.fehbg"
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "dunst"
    spawnOnce "picom --config ~/.config/picom/picom.conf"
    spawnOnce "/usr/bin/gnome-keyring-daemon --start --components=secrets"
    setWMName "LG3D"

-----------------------------
---------- XMOBAR -----------
-----------------------------
myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent         = xmobarColor tnBlue   "" . wrap "" ""   -- Current workspace
  , ppVisible         = xmobarColor tnPurple   ""              -- Visible but not current
  , ppHidden          = xmobarColor tnFg     "" . wrap "" ""   -- Hidden workspaces
  , ppHiddenNoWindows = xmobarColor tnComment ""               -- Hidden (no windows)
  , ppTitle           = xmobarColor tnFg "" . shorten 80  -- Active window title
  , ppSep             = "<fc=" ++ tnCyan ++ ">  \60272  </fc>"
  , ppLayout          = xmobarColor tnBlue ""
  , ppWsSep           = "  "
  , ppUrgent          = xmobarColor tnRed "" . wrap "!" "!"    -- Urgent workspace
  , ppOrder           = \(ws:l:t:ex) -> [ws,l]++ex++[t]
  }

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x   = [x]

-----------------------------
-------- WORKSPACES ---------
-----------------------------
myWorkspaces :: [String]
myWorkspaces =
  clickable . map xmobarEscape $ ["\62601 ", "\62057 ", "\985630 ", "\61564 ", "\987086 ", "\61878 "]
  where
    clickable l =
      [ "<action=xdotool key alt+" ++ show n ++ ">" ++ ws ++ "</action>"
      | (i, ws) <- zip [1..6] l
      , let n = i
      ]

-----------------------------
------- WINDOW RULES --------
-----------------------------
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "firefox"  --> doShift (myWorkspaces !! 1)
    , className =? "zen-beta" --> doShift (myWorkspaces !! 1)
    , className =? "Code"     --> doShift (myWorkspaces !! 2)
    , className =? "Thunar"   --> doShift (myWorkspaces !! 3)
    , className =? "vlc"      --> doShift (myWorkspaces !! 4)
    , className =? "steam"    --> doShift (myWorkspaces !! 5)
    , isFullscreen            --> doFullFloat
    , isDialog                --> doCenterFloat
    ] <+> manageDocks <+> namedScratchpadManageHook myScratchpads

-----------------------------
------- SCRATCHPADS ---------
-----------------------------
myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ NS "terminal" (mySecondTerminal ++ " -t scratchpad")       (title =? "scratchpad")      customFloatingRect
  , NS "paco"     "pavucontrol"                                (className =? "Pavucontrol") customFloatingRect
  , NS "rang"     (mySecondTerminal ++ " -t ranger -e ranger") (title =? "ranger")          customFloatingRect
  , NS "bitw"     "bitwarden-desktop"                          (className =? "Bitwarden")   customFloatingRect
  ]
  where
    customFloatingRect = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

-------------------------------------
---------- LAYOUTS ------------------
-------------------------------------
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Only Tall and Monocle layouts
tall    = renamed [Replace "\984640"]
        $ smartBorders
        $ mySpacing 8
        $ ResizableTall 1 (3/100) (1/2) []

monocle = renamed [Replace "\985967"]
        $ smartBorders
        $ Full

-- Layout hook - fullscreen hides xmobar automatically
myLayout = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
        where
            myDefaultLayout = withBorder myBorderWidth tall ||| noBorders monocle

-----------------------------
------- KEY BINDINGS --------
-----------------------------
myAditionalKeys :: [(String, X ())]
myAditionalKeys =

    -- Launchers
  [ ("M-<Return>",  spawn myTerminal)
  , ("M4-b",        spawn myBrowser)
  , ("M4-f",        spawn myFirefox)
  , ("M4-S-f",      spawn $ myFirefox ++ " -p")
  , ("M-<Space>",   spawn rofiLauncher)
  , ("M4-p",        spawn powerMenu)
  , ("M-d",         spawn myFileManager)
  , ("M4-c",        spawn myWorkEditor)
  , ("M4-w",        spawn wallChanger)
  , ("M-v",         spawn myEditor)
  , ("M4-s",        spawn mySteamLauncher)

  -- Volume Control
  , ("<XF86AudioRaiseVolume>", spawn volumeUp)
  , ("<XF86AudioLowerVolume>", spawn volumeDown)
  , ("<XF86AudioMute>",        spawn volumeMute)

  -- Window Management
  , ("M-S-c",       kill)
  , ("M-S-x",       killAll)
  , ("M-S-r",       spawn myRecompileRestart)
  , ("M-S-q",       io exitSuccess)

  -- Scratchpads
  , ("M4-1",        namedScratchpadAction myScratchpads "terminal")
  , ("M4-2",        namedScratchpadAction myScratchpads "paco")
  , ("M4-3",        namedScratchpadAction myScratchpads "rang")
  , ("M4-4",        namedScratchpadAction myScratchpads "bitw")

  -- Layouts and Workspaces
  , ("C-S-b",       spawn "killall xmobar")
  , ("M-<Tab>",     sendMessage NextLayout)
  , ("C-b",         sendMessage ToggleStruts)
  , ("C-M-<Left>",  prevWS)
  , ("C-M-<Right>", nextWS)
  , ("M1-1",        windows $ W.view $ myWorkspaces !! 0)
  , ("M1-2",        windows $ W.view $ myWorkspaces !! 1)
  , ("M1-3",        windows $ W.view $ myWorkspaces !! 2)
  , ("M1-4",        windows $ W.view $ myWorkspaces !! 3)
  , ("M1-5",        windows $ W.view $ myWorkspaces !! 4)
  , ("M1-6",        windows $ W.view $ myWorkspaces !! 5)
  , ("M1-S-1",      windows $ W.shift $ myWorkspaces !! 0)
  , ("M1-S-2",      windows $ W.shift $ myWorkspaces !! 1)
  , ("M1-S-3",      windows $ W.shift $ myWorkspaces !! 2)
  , ("M1-S-4",      windows $ W.shift $ myWorkspaces !! 3)
  , ("M1-S-5",      windows $ W.shift $ myWorkspaces !! 4)
  , ("M1-S-6",      windows $ W.shift $ myWorkspaces !! 5)

  -- Focus and Resizing
  , ("M4-<Left>",    windows W.focusDown)
  , ("M4-<Right>",   windows W.focusUp)
  , ("M4-S-m",       windows W.focusMaster)
  , ("M4-S-<Left>",  windows W.swapDown)
  , ("M4-S-<Right>", windows W.swapUp)
  , ("M4-C-<Left>",  sendMessage Shrink)
  , ("M4-C-<Right>", sendMessage Expand)
  , ("C-S-<Left>",   sendMessage $ IncMasterN 1)
  , ("C-S-<Right>",  sendMessage $ IncMasterN (-1))
  ]

myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
  [ ((m .|. modm, k), windows $ onCurrentScreen f i)
  | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
  [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
  , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
  , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
  ]
