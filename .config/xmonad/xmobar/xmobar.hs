Config { 

   -- appearance
     font               = "Iosevka Nerd Font Bold 11"
   , bgColor            = "#1e1e2e"
   , fgColor            = "#cdd6f4"
   --, position           = Static{xpos = 0, ypos = 0, width = 1525, height = 30 } --with trayer
   , position           = Static{xpos = 0, ypos = 0, width = 1920, height = 30 } --without trayer
   , alpha              = 255
   , border             = FullB
   , borderColor        = "#313244"

   -- layout
   , sepChar            = "%" -- delineator between plugin names and straight text
   , alignSep           = "}{" -- separator between left-right alignment
   , template           = " <icon=xmonad.xpm/>  %UnsafeStdinReader% }{ %cpu%  <fc=#89b4fa>%cputemp%</fc>  %memory%  <fc=#a6e3a1>%volume%</fc><fc=#fab387>%wifi%</fc> <fc=#f9e2af>%updates%</fc>  %date%  "

   -- general behavior
   , lowerOnStart       = True    -- send to bottom of window stack on start
   , hideOnStart        = False   -- start with window unmapped (hidden)
   , allDesktops        = True    -- show on all desktops
   , overrideRedirect   = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest       = False   -- choose widest display (multi-monitor)
   , persistent         = True    -- enable/disable hiding (True = disabled)
   , iconRoot           = "/home/owlsly/.config/xmonad/icons"

   -- plugins

   , commands = 

        -- CPU Usage
        [ Run Cpu             ["-t", "<fc=#cba6f7><fn=1> </fn> <total>%</fc>"] 20

        -- memory usage monitor
        , Run Memory          ["-t","<fc=#74c7ec><fn=1>  </fn><used>Mb</fc>"] 10

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date            "<fc=#fab387><fn=1> </fn> %H:%M  </fc><fc=#f38ba8><fn=1> </fn> %a, %d %b</fc>" "date" 10

        -- Check for volume
        , Run Com             ".config/xmonad/scripts/volume.sh" [] "volume" 10

        -- Check the weather
        , Run Weather         "LYNI" ["-t", "<fc=#a6e3a1><fn=1> </fn> <station> <tempC>°C</fc>" ] 36000

        -- Wifi Network
        , Run Com             ".config/xmonad/scripts/wifi.sh" [] "wifi" 36000

        -- Check for updates
        , Run Com             ".config/xmonad/scripts/updates.sh" [] "updates" 72000

        -- CPU Temp
        , Run Com             ".config/xmonad/scripts/cpu-temp.sh" [] "cputemp" 30

        , Run UnsafeStdinReader

        ]
   }
    
