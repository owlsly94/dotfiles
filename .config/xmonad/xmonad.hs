--                                                                                                                           
--            :.                           .:                             
--           +:-=-                      .-=:=.                            
--          :=+*+:=:.::---:::::::::::. ===**:+                            
--          *+****=----==++*****+++====-+****=:                           
--         =*******#***##*********##***#*****++                           
--        .#***#*+-:::::-=*#***#*=-:::::-+*#***-                          
--        +****-::-+****=-:-*#*-::-+***+=-:-*#*#                          
--        #***::-*=  .+@@@*-:-::-#=  .+@@%+::**#.                         
--       :#*#:::#%     @@@@*:::-%%     @@@@+:-#*=                         
--       +**#:::@@#=-=%@@@@%:::=@@#=-+%@@@@*::#**                         
--       #**#-::*@@@@@%:.*@+::::#@@@@@%:.*@=:-#*#                         
--      .#***#-::+%@@@%=-+++===+-*%@@@%=-+-:-#**#:                        
--      -#****#+-::-=++=-=+:---:*-:==++=-:-+#***#-                        
--      ====+***#*+++=+++*#=---=#*+++=+++*#**+=--=                        
--      +***+==********+==+**+**+=++*******=-+***=                        
--      =******=+***=-:::::-=+=-::::--+***-******-                        
--      -*******=#+=-::=::::::::::-=::=-#=******#.                        
--      .#*******#::====:::+--==:::=++=:********#                         
--       *******#+::::::::::==-:::::::::+#******=                         
--       :#*****%=::::--::--:::=:::=::::=%*****#                          
--        *#**##%::::::++++-:::-+=+-::::-%##**#:                          
--         *#####=-::::::::::::::::::::-=#####-                           
--          =##%+==+=---:::-:::-:::=--=+=+%##:                            
--           .+%+==+***+===+++++===+***==+#-                              
--              -+*+========++=======+*+=.                                
--                .*******************:                                   
--                +=+#+=*=+: .*+*++#+=*                                   
--                   +-=+++- :++++-*                                      
--                    :.         .:                                       
--                                                                        
--   .d88888b.                888          888          
--  d88P" "Y88b               888          888          
--  888     888               888          888          
--  888     888 888  888  888 888 .d8888b  888 888  888 
--  888     888 888  888  888 888 88K      888 888  888 
--  888     888 888  888  888 888 "Y8888b. 888 888  888 
--  Y88b. .d88P Y88b 888 d88P 888      X88 888 Y88b 888 
--   "Y88888P"   "Y8888888P"  888  88888P' 888  "Y88888 
--                                                  888 
--                                             Y8b d88P 
--                                              "Y88P"  
--
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
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)

-- Config
import XMonad.Config.Desktop
import XMonad.Config.Azerty

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
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
myNormalBorderColor   = "#45475a"
myFocusedBorderColor  = "#cba6f7"

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
------- MUSIC PLAYER --------
-----------------------------
myMusicPlayer :: String
myMusicPlayer = myTerminal ++ " -e mocp"

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
mySpotify = "brave-browser --app=https://open.spotify.com/"

-----------------------------
-------- SPOTIFY ------------
-----------------------------
myChatGPT :: String
myChatGPT = "brave-browser --app=https://chat.openai.com"

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
-------- WORKSPACES ---------
-----------------------------
xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x   = [x]

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
  , NS "mocp"      (mySecondTerminal ++ " -t mocp -e mocp")     (title =? "mocp")            customFloatingRect
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

-- Layout hook
myLayout = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
        where
            myDefaultLayout = withBorder myBorderWidth tall ||| noBorders monocle

-----------------------------
------ MOUSE BINDINGS -------
-----------------------------
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))

    ]

-----------------------------
------- KEY BINDINGS --------
-----------------------------
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  
  -- Custom keys
  [ ((modMask,  xK_Return),                   spawn $ myTerminal )
  , ((mod4Mask, xK_f),                        spawn $ myBrowser )
  , ((mod4Mask .|. shiftMask, xK_f),          spawn $ myBrowser ++ " -p" )
  , ((mod4Mask, xK_b),                        spawn $ myBrave )
  , ((modMask,  xK_p),                        spawn $ dMenu )
  , ((mod4Mask, xK_p),                        spawn $ rofiLauncher )
  , ((modMask,  xK_d),                        spawn $ myFileManager )
  , ((mod4Mask, xK_c),                        spawn $ myWorkEditor )
  , ((mod4Mask, xK_m),                        spawn $ myMusicPlayer )
  , ((mod4Mask, xK_r),                        spawn $ powerMenu )
  , ((mod4Mask, xK_w),                        spawn $ wallChanger )
  , ((modMask,  xK_v),                        spawn $ myEditor )
  , ((mod4Mask, xK_s),                        spawn $ mySteamLauncher )

  -- Sound Keys
  , ((modMask, xK_F3),                        spawn $ volumeUp )
  , ((modMask, xK_F2),                        spawn $ volumeDown )
  , ((modMask, xK_F4),                        spawn $ volumeMute )
  , ((modMask, xK_F1),                        spawn $ volumeUnmute )

  -- Kill window/s, Restart, Shutdown Keys
  , ((modMask .|. shiftMask, xK_c),           kill1 )
  , ((modMask .|. shiftMask, xK_x),           killAll )
  , ((modMask .|. shiftMask , xK_r ),         spawn $ myRecompileRestart )
  , ((modMask .|. shiftMask, xK_q),           io (exitWith ExitSuccess) )

  -- Scratchpads
  , ((mod4Mask, xK_1),                        namedScratchpadAction myScratchpads "terminal")
  , ((mod4Mask, xK_2),                        namedScratchpadAction myScratchpads "mocp")
  , ((mod4Mask, xK_3),                        namedScratchpadAction myScratchpads "paco")
  , ((mod4Mask, xK_4),                        namedScratchpadAction myScratchpads "rang")
  , ((mod4Mask, xK_5),                        namedScratchpadAction myScratchpads "bitw")
  , ((mod4Mask, xK_g),                        namedScratchpadAction myScratchpads "chgt" )
  , ((mod4Mask, xK_m),                        namedScratchpadAction myScratchpads "spot" )

  -- Switch Layouts
  , ((modMask, xK_space),                     sendMessage NextLayout)

  -- Kill XMobar
  , ((controlMask .|. shiftMask, xK_b),       spawn $ "killall xmobar")

  -- XMobar show and hide
  , ((controlMask, xK_b),                     sendMessage $ ToggleStruts)

  -- Toggle Fullscreen with no borders
  , ((modMask, xK_n),                         sendMessage $ Toggle NBFULL)

  -- Switch workspaces
  , ((controlMask .|. modMask , xK_Left ),    prevWS)
  , ((controlMask .|. modMask , xK_Right ),   nextWS)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),       setLayout $ XMonad.layoutHook conf)

  -- Move focus on a window
  , ((mod4Mask, xK_Left),                     windows W.focusDown)
  , ((mod4Mask, xK_Right),                    windows W.focusUp  )

  -- Move focus to the master window.
  , ((mod4Mask .|. shiftMask, xK_m),          windows W.focusMaster  )

  -- Swap master window with stack
  , ((mod4Mask .|. shiftMask, xK_Left),       windows W.swapDown  )
  , ((mod4Mask .|. shiftMask, xK_Right),      windows W.swapUp    )

  -- Shrink and expand the master area.
  , ((controlMask .|. shiftMask , xK_Left),   sendMessage Shrink)
  , ((controlMask .|. shiftMask , xK_Right),  sendMessage Expand)

  -- Push window back into tiling.
  , ((controlMask .|. shiftMask , xK_t),      withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((controlMask .|. mod4Mask, xK_Left),     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((controlMask .|. mod4Mask, xK_Right),    sendMessage (IncMasterN (-1)))

  ]
  ++

  [((m .|. modMask, k), windows $ f i)

  --Keyboard layouts
   | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]

      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]]

  ++

  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_Left, xK_Right] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-----------------------------
------- MAIN CONFIG ---------
-----------------------------
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmonad/xmobar/xmobar.hs"
    xmonad . ewmh $
        desktopConfig
                { startupHook = myStartupHook
                , layoutHook = myLayout
                , manageHook = manageSpawn <+> myManageHook <+> manageHook desktopConfig
                , modMask = myModMask
                , borderWidth = myBorderWidth
                , handleEventHook    = handleEventHook desktopConfig
                , focusFollowsMouse = myFocusFollowsMouse
                , workspaces = myWorkspaces
                , focusedBorderColor = myFocusedBorderColor
                , normalBorderColor = myNormalBorderColor
                , keys = myKeys
                , mouseBindings = myMouseBindings
                , logHook = dynamicLogWithPP xmobarPP
                          { ppOutput = \x -> hPutStrLn xmproc x
                          , ppCurrent = xmobarColor greenColor "" . wrap "" "" -- Current workspace in xmobar
                          , ppVisible = xmobarColor redColor ""                -- Visible but not current workspace
                          , ppHidden = xmobarColor purpleColor "" . wrap "" ""   -- Hidden workspaces in xmobar
                          , ppHiddenNoWindows = xmobarColor fgColor ""    -- Hidden workspaces (no windows)
                          , ppTitle = xmobarColor textColor "" . shorten 60   -- Title of active window in xmobar
                          , ppSep =  "<fc=#f5e0dc>  \60272  </fc>"                     -- Separators in xmobar
                          , ppLayout = xmobarColor lavanderColor ""
                          , ppWsSep = "  "
                          , ppUrgent = xmobarColor redColor "" . wrap "!" "!"  -- Urgent workspace
                          , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                          --, ppOrder  = \(ws:_:t:_) -> [ws,t]
                          }
                }
