-- Base
import XMonad
import Data.Monoid
import System.Exit
import Text.Printf
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Layouts
import XMonad.Layout.Grid

-- Layout Modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Renamed (named)
import XMonad.Layout.Spacing

-- Actions
import XMonad.Actions.ToggleFullFloat

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.Place
import XMonad.Hooks.StatusBar
import XMonad.Hooks.WindowSwallowing

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

-- MAIN OPTIONS --------------------------------------------------------

myTerminal, myEditor :: String
myTerminal = "st"
myEditor = "nvim"

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myBorderWidth :: Dimension
myBorderWidth = 1

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#80b7ff"

-- KEY BINDS -----------------------------------------------------------

myKeys :: [(String, X ())]
myKeys =
    -- Spawning programs
    [ ("M-<Return>", spawn myTerminal)
    , ("M-p", spawnDmenu "dmenu_run")
    , ("M-w", spawn "firefox")
    , ("M-C-q", spawn "qutebrowser")
    , ("M-e", spawnTerminal myEditor)
    , ("M-f", spawnTerminal "nnn")
    , ("M-t", spawnTerminal "ncmpcpp")
    , ("M-C-e", spawnTerminal "ncspot")
    , ("M-v", spawnTerminal "pulsemixer")
    , ("M-S-t", spawn "pavucontrol")
    , ("M-S-;", spawn "simplescreenrecorder")
    , ("M-S-'", spawn "obs")
    , ("M-S-o", spawnTerminal "cava")
    , ("M-C-l", spawn "run-i3lock")
    , ("M-C-d", spawn "arandr")
    , ("M-C-v", spawn "screenlayouts-open")
    , ("M-C-w", spawn "wallpapers-open")
    , ("M-C-[", spawn "find ~/pictures/screenshots -type f | nsxiv -ti")

    -- Screenshotting
    , ("<Print>", spawn "epicshot -cs select")
    , ("C-<Print>", spawn "epicshot -cs full")
    , ("M-<Print>", spawn "epicshot -so select")
    , ("M-C-r", spawn "epicshot -cs select")
    , ("M-C-t", spawn "epicshot -cs full")
    , ("M-C-g", spawn "epicshot -so select")

    -- Custom function row
    , ("M-C-<F5>", spawn "mpc prev")
    , ("M-C-<F6>", spawn "mpc next")
    , ("M-C-<F7>", spawn "mpc toggle")
    , ("M-C-<F8>", spawn "mpc stop")
    , ("M-C-<F9>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pipe_volume")
    , ("M-C-<F10>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pipe_volume")
    , ("M-C-<F11>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && pipe_volume")
    , ("M-C-<F12>", spawn "run-i3lock")

    -- XF86 keys
    , ("<XF86Explorer>", spawnTerminal "nnn")
    , ("<XF86Search>", spawnDmenu "dmenu_run")
    , ("<XF86Calculator>", spawnTerminal "bc -i")
    , ("<XF86Tools>", spawnTerminal "ncmpcpp")
    , ("<XF86AudioPrev>", spawn "mpc prev")
    , ("<XF86AudioNext>", spawn "mpc next")
    , ("<XF86AudioPlay>", spawn "mpc toggle")
    , ("<XF86AudioStop>", spawn "mpc stop")
    , ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pipe_volume")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pipe_volume")
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && pipe_volume")

    -- Layouts
    , ("M-a M-t", sendMessage $ JumpToLayout "tall")
    , ("M-a M-y", sendMessage $ JumpToLayout "wide")
    , ("M-a M-g", sendMessage $ JumpToLayout "grid")
    , ("M-a M-a", sendMessage NextLayout)

    -- Window focus/swap
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)

    -- Master control
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)
    , ("M-i", sendMessage $ IncMasterN 1)
    , ("M-d", sendMessage $ IncMasterN $ -1)
    , ("M-s", windows W.focusMaster)
    , ("M-S-s", windows W.swapMaster)

    -- Window actions
    , ("M-S-c", kill)
    , ("M-S-f", withFocused toggleFullFloat)
    , ("M-S-<Space>", withFocused toggleFloat)

    -- Scratchpads
    , ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
    , ("M-C-c", namedScratchpadAction myScratchPads "ncmpcpp")

    -- Session
    , ("M-C-<Delete>", io $ exitWith ExitSuccess)
    , ("M-C-s", spawn "xmonad --recompile && xmonad --restart")
    ] ++

    -- View workspace N
    [ ("M-" ++ show i, windows $ W.greedyView $ myWorkspaces !! (i-1))
    | i <- [1..9]
    ] ++

    -- Shift window to workspace N
    [ ("M-S-" ++ show i, windows $ W.shift $ myWorkspaces !! (i-1))
    | i <- [1..9]
    ]
  where
    toggleFloat :: Window -> X ()
    toggleFloat w = do
        isFloating <- gets (M.member w . W.floating . windowset)
        if isFloating
            then windows $ W.sink w
            else withFocused float
    
    spawnTerminal :: String -> X ()
    spawnTerminal x = do
        spawn $ printf "%s -e %s" myTerminal x
    
    spawnEditor :: String -> X ()
    spawnEditor x = do
        spawnTerminal $ printf "%s %s" myEditor x
    
    spawnDmenu :: String -> X ()
    spawnDmenu x = do
        spawn $ printf "%s -h %s -fn %s -nb '%s' -nf '%s' -sb '%s' -sf '%s'" x "17" "Terminus-8" "#1d2021" "#ebdbb2" "#fabd2f" "#282828"

-- MOUSE BINDS ---------------------------------------------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

-- LAYOUTS -------------------------------------------------------------

myLayoutHook =
    avoidStruts
    $ tall ||| wide ||| grid
  where
    tall = named "tall"
        $ Tall 1 (3/100) (1/2)
    wide = named "wide"
        $ Mirror tall
    grid = named "grid"
        $ Grid

-- SCRATCHPADS ---------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads =
    [ constructScratchpad "terminal" "scTerminal" Nothing
    , constructScratchpad "ncmpcpp" "scNcmpcpp" (Just "ncmpcpp")
    ]
  where
    constructScratchpad :: String -> String -> Maybe String -> NamedScratchpad
    constructScratchpad name cls maybeExec =
        NS name
          (case maybeExec of
              Just exec -> printf "%s -c %s -e %s" myTerminal cls exec
              Nothing   -> printf "%s -c %s" myTerminal cls
          )
          (className =? cls)
          (customFloating $ W.RationalRect (3/5) (4/6) (1/5) (1/6))

-- HOOKS ---------------------------------------------------------------

myManageHook :: ManageHook
myManageHook = composeAll
    [ placeHook $ smart (0.5, 0.5)
    , namedScratchpadManageHook myScratchPads
    , insertPosition End Newer
    , manageDocks
    , composeAll [ className =? c --> doFloat | c <- floatClasses ]
    ]
  where
    floatClasses = ["Arandr", "Nsxiv"]

myEventHook :: Event -> X All
myEventHook =
    swallowEventHook (foldr1 (<||>)
    $ map (\c -> className =? c) swallowClasses) (return True)
  where
    swallowClasses = ["St", "XTerm"]

myStartupHook :: X ()
myStartupHook = do
    spawn "sleep 0.5 && initialize_pipes"

-- XMOBAR --------------------------------------------------------------

myPP :: PP
myPP = def
    { ppSep             = sep " : "
    , ppCurrent         = current . wrap "" "*"
    , ppHidden          = noScratchPad
    , ppHiddenNoWindows = \_ -> ""
    }
  where
    noScratchPad :: String -> String
    noScratchPad ws = if ws == "NSP" then "" else ws

    sep, current :: String -> String
    sep     = xmobarColor "#777777" ""
    current = xmobarColor "#6eadff" ""

-- MAIN ----------------------------------------------------------------

main :: IO ()
main = xmonad
    . withSB (statusBarProp "xmobar" $ pure myPP)
    . toggleFullFloatEwmhFullscreen
    . ewmhFullscreen
    . ewmh
    $ myConfig

myConfig = def
    { borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , startupHook        = myStartupHook
    , focusFollowsMouse  = True
    , clickJustFocuses   = False
    , modMask            = mod4Mask
    , mouseBindings      = myMouseBindings
    }
  `additionalKeysP` myKeys
