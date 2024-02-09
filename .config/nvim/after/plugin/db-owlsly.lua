require("dashboard").setup {
            theme = "hyper",
            config = {
              header = {
                          "",
                          "",
                          "  ██████╗ ██╗    ██╗██╗     ███████╗██╗  ██╗   ██╗ ",
                          " ██╔═══██╗██║    ██║██║     ██╔════╝██║  ╚██╗ ██╔╝ ",
                          " ██║   ██║██║ █╗ ██║██║     ███████╗██║   ╚████╔╝  ",
                          " ██║   ██║██║███╗██║██║     ╚════██║██║    ╚██╔╝   ",
                          " ╚██████╔╝╚███╔███╔╝███████╗███████║███████╗██║    ",
                          "  ╚═════╝  ╚══╝╚══╝ ╚══════╝╚══════╝╚══════╝╚═╝    ",
                          "",
                          "",
                        },
              shortcut = {
                { desc = '󰊳  Update', group = '@property', action = 'Lazy update', key = 'u' },
                {
                  icon = '  ',
                  icon_hl = '@variable',
                  desc = 'Files',
                  group = 'Label',
                  action = 'Telescope find_files',
                  key = 'f',
                },
                {
                  desc = '󰗼  exit',
                  group = '',
                  action = 'exit',
                  key = 'q',
                },
                      },
                    }
                  }


