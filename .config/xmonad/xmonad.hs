--             :.                           .:       
--            +:-=-                      .-=:=.     
--           :=+*+:=:.::---:::::::::::. ===**:+     
--           *+****=----==++*****+++====-+****=:    
--          =*******#***##*********##***#*****++    
--         .#***#*+-:::::-=*#***#*=-:::::-+*#***-   
--         +****-::-+****=-:-*#*-::-+***+=-:-*#*#   
--         #***::-*=  .+@@@*-:-::-#=  .+@@%+::**#.  
--        :#*#:::#%     @@@@*:::-%%     @@@@+:-#*=  
--        +**#:::@@#=-=%@@@@%:::=@@#=-+%@@@@*::#**  
--        #**#-::*@@@@@%:.*@+::::#@@@@@%:.*@=:-#*#  
--       .#***#-::+%@@@%=-+++===+-*%@@@%=-+-:-#**#: 
--       -#****#+-::-=++=-=+:---:*-:==++=-:-+#***#- 
--       ====+***#*+++=+++*#=---=#*+++=+++*#**+=--= 
--       +***+==********+==+**+**+=++*******=-+***= 
--       =******=+***=-:::::-=+=-::::--+***-******- 
--       -*******=#+=-::=::::::::::-=::=-#=******#. 
--       .#*******#::====:::+--==:::=++=:********#  
--        *******#+::::::::::==-:::::::::+#******=  
--        :#*****%=::::--::--:::=:::=::::=%*****#   
--         *#**##%::::::++++-:::-+=+-::::-%##**#:   
--          *#####=-::::::::::::::::::::-=#####-    
--           =##%+==+=---:::-:::-:::=--=+=+%##:     
--            .+%+==+***+===+++++===+***==+#-       
--               -+*+========++=======+*+=.         
--                 .*******************:            
--                 +=+#+=*=+: .*+*++#+=*            
--                    +-=+++- :++++-*               
--                     :.         .:                 
--
--  .d88888b.                888          888         
-- d88P" "Y88b               888          888         
-- 888     888               888          888         
-- 888     888 888  888  888 888 .d8888b  888 888  888
-- 888     888 888  888  888 888 88K      888 888  888
-- 888     888 888  888  888 888 "Y8888b. 888 888  888
-- Y88b. .d88P Y88b 888 d88P 888      X88 888 Y88b 888
--  "Y88888P"   "Y8888888P"  888  88888P' 888  "Y88888
--                                                 888 
--                                            Y8b d88P 
--                                             "Y88P"  
------------------------------------------------------
-----------------------------
---------- IMPORTS ----------
-----------------------------

import System.IO
import System.Exit
import XMonad

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)

-- Config
import XMonad.Config.Desktop
import XMonad.Config.Azerty

-- Utils
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import XMonad.Actions.SpawnOn
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Actions.WithAll
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Util.NamedScratchpad

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.CenteredMaster(centerMaster)
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed
import XMonad.Layout.Grid

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)

-- Colors
import Colors.CatppuccinMocha

-----------------------------
--------- AUTOSTART ---------
-----------------------------
myStartupHook :: X ()
myStartupHook = mapM_ spawnOnce
  [ "~/.fehbg"
  , "nm-applet"
  , "xfce4-power-manager"
  , "killall dunst"
  , "dunst"
  , "picom --config ~/.config/picom/picom.conf"
  , "setWMName \"LG3D\""
  ]

-----------------------------
---------- COLORS -----------
-----------------------------
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor   = base01
myFocusedBorderColor  = base05

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
myBrowser, myBrave :: String
myBrowser = "firefox"
myBrave = "brave"

-----------------------------
------- FILE MANAGER --------
-----------------------------
myFileManager :: String
myFileManager = "pcmanfm"

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
volumeUp, volumeDown, volumeMute, volumeUnmute :: String
volumeUp     = "pamixer -i 5"
volumeDown   = "pamixer -d 5"
volumeMute   = "pamixer --mute"
volumeUnmute = "pamixer --unmute"

-----------------------------
--------- LAUNCHERS ---------
-----------------------------
dMenu, rofiLauncher :: String
dMenu        = "dmenu_run -nb '#1f1d2e' -nf '#89b4fa' -sb '#89b4fa' -sf '#1f1d2e'"
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
-------- SPOTIFY ------------
-----------------------------
mySpotify :: String
mySpotify = "brave --app=https://open.spotify.com/"

-----------------------------
-------- SPOTIFY ------------
-----------------------------
myChatGPT :: String
myChatGPT = "brave --app=https://chat.openai.com"

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
    { startupHook         = myStartupHook
    , layoutHook          = myLayout
    , manageHook          = manageSpawn <+> myManageHook <+> manageHook def
    , modMask             = myModMask
    , borderWidth         = myBorderWidth
    , handleEventHook     = handleEventHook def
    , focusFollowsMouse   = myFocusFollowsMouse
    , workspaces          = myWorkspaces
    , focusedBorderColor  = myFocusedBorderColor
    , normalBorderColor   = myNormalBorderColor
    , keys                = myKeys
    , mouseBindings       = myMouseBindings
    , logHook             = dynamicLogWithPP myXmobarPP
        { ppOutput        = hPutStrLn xmproc }
    } `additionalKeysP` myAditionalKeys

-----------------------------
---------- XMOBAR -----------
-----------------------------
myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent         = xmobarColor base09 "" . wrap "" ""    -- Current workspace in xmobar
  , ppVisible         = xmobarColor base03 ""                 -- Visible but not current workspace
  , ppHidden          = xmobarColor base05 "" . wrap "" ""    -- Hidden workspaces in xmobar
  , ppHiddenNoWindows = xmobarColor base01 ""                 -- Hidden workspaces (no windows)
  , ppTitle           = xmobarColor base02 "" . shorten 60    -- Title of active window in xmobar
  , ppSep             =  "<fc=#f5e0dc>  \60272  </fc>"        -- Separators in xmobar
  , ppLayout          = xmobarColor base04 ""
  , ppWsSep           = "  "
  , ppUrgent          = xmobarColor base03 "" . wrap "!" "!"  -- Urgent workspace
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
  clickable . map xmobarEscape $ ["\62601 ", "\62057 ", "\985630 ", "\61564 ", "\987086 ", "\61878 " ]
  where
    clickable l =
      [ "<action=xdotool key alt+" ++ show n ++ ">" ++ ws ++ "</action>"
      | (i,ws) <- zip [1..6] l
      , let n = i
      ]

-----------------------------
------- WINDOW RULES --------
-----------------------------
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "firefox"       --> doShift (myWorkspaces !! 1)
    , className =? "Brave-browser" --> doShift (myWorkspaces !! 1)
    , className =? "Code"          --> doShift (myWorkspaces !! 2)
    , className =? "Pcmanfm"       --> doShift (myWorkspaces !! 3)
    , className =? "vlc"           --> doShift (myWorkspaces !! 4)
    , className =? "steam"         --> doShift (myWorkspaces !! 5)
    , isFullscreen                 --> doFullFloat
    , isDialog                     --> doCenterFloat
    ] <+> manageDocks <+> namedScratchpadManageHook myScratchpads

-----------------------------
------- SCRATCHPADS ---------
-----------------------------
myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ NS "terminal"  (mySecondTerminal ++ " -t scratchpad")       (title =? "scratchpad")      customFloatingRect
  , NS "paco"      "pavucontrol"                                (className =? "Pavucontrol") customFloatingRect
  , NS "rang"      (mySecondTerminal ++ " -t ranger -e ranger") (title =? "ranger")          customFloatingRect
  , NS "bitw"      "bitwarden-desktop"                          (className =? "Bitwarden")   customFloatingRect
  , NS "chgt"      myChatGPT                                    (title =? "ChatGPT")         customFloatingRect
  , NS "spot"      mySpotify                                    (title =? "Spotify")         customFloatingRect
  ]
  where
    customFloatingRect = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

-----------------------------
--------- LAYOUTS -----------
-----------------------------
-- Gaps around and in between the windows
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts customization
tall    = renamed [Replace "\984640"]
        $ smartBorders
        $ mySpacing 8
        $ ResizableTall 1 (3/100) (1/2) []
monocle = renamed [Replace "\985967"]
        $ smartBorders
        $ Full
grid    = renamed [Replace "\984920"]
        $ smartBorders
        $ mySpacing 8
        $ Grid

-- Layout hook
myLayout = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
        where
            myDefaultLayout = withBorder myBorderWidth tall ||| noBorders monocle ||| grid

-----------------------------
------- KEY BINDINGS --------
-----------------------------
myAditionalKeys :: [(String, X ())]
myAditionalKeys =

    -- Custom keys
  [ ("M-<Return>",  spawn $ myTerminal)
  , ("M4-f",        spawn $ myBrowser)
  , ("M4-S-f",      spawn $ myBrowser ++ " -p")
  , ("M4-b",        spawn $ myBrave)
  , ("M-p",         spawn $ rofiLauncher)
  , ("M4-p",        spawn $ powerMenu)
  , ("M4-d",        spawn $ dMenu)
  , ("M-d",         spawn $ myFileManager)
  , ("M4-c",        spawn $ myWorkEditor)
  , ("M4-w",        spawn $ wallChanger)
  , ("M-v",         spawn $ myEditor)
  , ("M4-s",        spawn $ mySteamLauncher)

  -- Sound control keys
  , ("<F2>",        spawn $ volumeDown)
  , ("<F3>",        spawn $ volumeUp)
  , ("<F4>",        spawn $ volumeMute)
  , ("<F1>",        spawn $ volumeUnmute)

  -- Kill window/s, restart, shutdown keys
  , ("M-S-c",       kill1)
  , ("M-S-x",       killAll)
  , ("M-S-r",       spawn $ myRecompileRestart)
  , ("M-S-q",       io exitSuccess)

  -- Scratchpads 
  , ("M4-1",        namedScratchpadAction myScratchpads "terminal")
  , ("M4-2",        namedScratchpadAction myScratchpads "paco")
  , ("M4-3",        namedScratchpadAction myScratchpads "rang")
  , ("M4-4",        namedScratchpadAction myScratchpads "bitw")
  , ("M4-g",        namedScratchpadAction myScratchpads "chgt")
  , ("M4-m",        namedScratchpadAction myScratchpads "spot")

  -- Layouts, Workspaces, Focusing, XMobar, Swapping, Shrinking, Incrementing
  , ("C-S-b",       spawn $ "killall xmobar")
  , ("M-<Space>",   sendMessage NextLayout)
  , ("C-b",         sendMessage $ ToggleStruts)
  , ("M-n",         sendMessage $ Toggle NBFULL)
  , ("C-M-<Left>",  prevWS)
  , ("C-M-<Right>", nextWS)

  -- Window controls
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
 [((m .|. modm, k), windows $ onCurrentScreen f i)
 | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
 ]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
  [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
  ]
