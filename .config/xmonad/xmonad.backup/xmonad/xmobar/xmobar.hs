Config
  -- Appearance
  { font         = "JetBrainsMonoNL NF Bold 11"
  , bgColor      = "#1f2335"
  , fgColor      = "#c0caf5"
  , position     = Static { xpos = 0, ypos = 0, width = 1920, height = 30 }
  , alpha        = 255
  , border       = FullB
  , borderColor  = "#292e42"

  -- Layout
  , sepChar      = "%"
  , alignSep     = "}{"
  , template     = " <icon=xmonad.xpm/>  %UnsafeStdinReader% }{ %cpu%  |  %cputemp%  |  %memory%  |  <fc=#9ece6a>%volume%</fc>  |  <fc=#e0af68>%updates%</fc>  |  %date%  "

  -- General
  , lowerOnStart     = True
  , hideOnStart      = False
  , allDesktops      = True
  , overrideRedirect = True
  , pickBroadest     = False
  , persistent       = True
  , iconRoot         = "/home/owlsly/.config/xmonad/icons"

  -- Plugins
  , commands =
      [ Run Cpu
          [ "-t", "<fc=#bb9af7><fn=1>\xf4bc</fn> <total>%</fc>" ] 20

      , Run Memory
          [ "-t", "<fc=#7aa2f7><fn=1>\xf035b</fn> <used>Mb</fc>" ] 10

      , Run Date
          "<fc=#f7768e><fn=1>\xf017</fn> %H:%M  <fn=1>\xf073</fn> %a, %d %b</fc>"
          "date" 10

      , Run Com ".config/xmonad/scripts/volume.sh"   [] "volume"  10
      , Run Com ".config/xmonad/scripts/updates.sh"  [] "updates" 72000
      , Run Com ".config/xmonad/scripts/cpu-temp.sh" [] "cputemp" 30

      , Run UnsafeStdinReader
      ]
  }
