import Xmobar

config :: Config
config = defaultConfig
    { font       = "Terminus 8"
    , textOffset = 0
    , bgColor    = "#121212"
    , fgColor    = "#cccccc"
    , position   = Top
    , template   = " %XMonadLog% }{ %network% <fc=#777777>|</fc> VOL %volume% <fc=#777777>|</fc> %battery% <fc=#777777>|</fc> CPU %cpu% <fc=#777777>|</fc> RAM %memory% <fc=#777777>|</fc> %load% <fc=#777777>|</fc> <fc=#f7e83b>%date%</fc> "
    , commands   =
        [ Run XMonadLog
        , Run $ Com "monitors" ["network"] "network" 6000
        , Run $ PipeReader "/tmp/pipe-volume" "volume"
        , Run $ Com "monitors" ["battery"] "battery" 3600
        , Run $ Com "monitors" ["cpu"] "cpu" 50
        , Run $ Com "monitors" ["memory"] "memory" 50
        , Run $ Com "monitors" ["load"] "load" 600
        , Run $ Date "%d/%m/%Y %H:%M:%S" "date" 10
        ]
    }

main :: IO ()
main = xmobar config
