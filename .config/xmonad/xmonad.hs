import XMonad
import Data.Monoid
import System.Exit
import Text.Printf
import qualified Data.Map as M
import qualified XMonad.StackSet as W

import XMonad.Layout.Grid

import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayout(Toggle))

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Place
import XMonad.Hooks.StatusBar
import XMonad.Hooks.WindowSwallowing

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

-- MAIN OPTIONS --------------------------------------------------------

myTerminal, myEditor :: String
myTerminal = "xfce4-terminal --disable-server"
myEditor = "vim"

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myBorderWidth :: Dimension
myBorderWidth = 1

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "#504945"
myFocusedBorderColor = "#fabd2f"

mySpacing :: Int
mySpacing = 8

-- KEY BINDS -----------------------------------------------------------

myKeys :: [(String, X ())]
myKeys =
    -- Common programs
    [ ("M-<Return>", spawn myTerminal)
    , ("M-w", spawn "firefox")
    , ("M-f", spawn "thunar")
    , ("M-o", spawnTerminal "ncspot")
    , ("M-c", spawnTerminal "pulsemixer")
    , ("M-e", spawnTerminal "nvim")
    , ("M-p", spawnDmenu "dmenu_run")

    -- Screenshotting
    , ("<Print>", spawn "epicshot -cs select")
    , ("C-<Print>", spawn "epicshot -cs full")
    , ("M-<Print>", spawn "epicshot -so select")
    , ("M-C-r", spawn "epicshot -cs select")
    , ("M-C-t", spawn "epicshot -cs full")
    , ("M-C-g", spawn "epicshot -so select")

    -- System management utilities
    , ("M-C-l", spawn "run-i3lock")
    , ("M-C-w", spawn "wallpapers-open")
    , ("M-C-d", spawn "arandr")
    , ("M-C-v", spawn "screenlayouts-open")

    -- Volume control
    , ("M-C-<F9>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pipe_volume")
    , ("M-C-<F10>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pipe_volume")
    , ("M-C-<F11>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && pipe_volume")
    , ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pipe_volume")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pipe_volume")
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && pipe_volume")

    -- Layouts
    , ("M-<Tab>", sendMessage NextLayout)
    , ("M-t", sendMessage $ JumpToLayout "tall")
    , ("M-y", sendMessage $ JumpToLayout "wide")
    , ("M-m", sendMessage $ JumpToLayout "full")

    -- Window focus
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)

    -- Master focus/swap
    , ("M-v", windows W.focusMaster)
    , ("M-S-v", windows W.swapMaster)

    -- Swap windows
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)

    -- Master area
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)

    -- Window actions
    , ("M-S-c", kill)
    , ("M-S-f", sendMessage $ Toggle "full")
    , ("M-S-<Space>", withFocused toggleFloat)

    -- Master amount
    , ("M-i", sendMessage $ IncMasterN 1)
    , ("M-d", sendMessage $ IncMasterN $ -1)

    -- Scratchpads
    , ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
    , ("M-C-c", namedScratchpadAction myScratchPads "music")

    -- Window spacing
    , ("M-S-i", incWindowSpacing 4)
    , ("M-S-d", decWindowSpacing 4)

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

-- MOUSE BINDS ---------------------------------------------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

-- LAYOUTS -------------------------------------------------------------

tall = named "tall"
    $ spacing mySpacing
    $ Tall 1 (3/100) (1/2)
wide = named "wide"
    $ Mirror tall
grid = named "grid"
    $ spacing mySpacing
    $ Grid
full = named "full"
    $ spacing mySpacing
    $ Full

myLayoutHook =
    avoidStruts
    $ tall ||| wide ||| grid ||| full

-- SCRATCHPADS ---------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads =
    [ NS "terminal" "st -c scratchpad" (className =? "scratchpad") $ customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
    , NS "music" "st -c ncspot -e ncspot" (className =? "ncspot") $ customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
    ]

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
    swallowEventHook (foldr1 (<||>) $ map (\c -> className =? c) swallowClasses) (return True)
  where
    swallowClasses = ["xfce4-terminal", "XTerm"]

myStartupHook :: X ()
myStartupHook = do
    spawn "sleep 0.5 && initialize_pipes"

-- XMOBAR --------------------------------------------------------------

myPP :: PP
myPP = def
    { ppSep             = bg4 " | "
    , ppCurrent         = wrap (fg2 "[") (fg2 "]") . yellow
    , ppHidden          = gray . noScratchPad
    , ppHiddenNoWindows = \_ -> ""
    }
  where
    noScratchPad :: String -> String
    noScratchPad ws = if ws == "NSP" then "" else ws

    yellow, gray, bg4, fg2 :: String -> String
    yellow = xmobarColor "#fabd2f" ""
    gray   = xmobarColor "#a89984" ""
    bg4    = xmobarColor "#7c6f64" ""
    fg2    = xmobarColor "#d5c4a1" ""

-- MAIN ----------------------------------------------------------------

main :: IO ()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . withSB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc-top" $ pure myPP)
    . withSB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc-bottom" $ pure myPP)
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

-- FUNCTIONS -----------------------------------------------------------

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
    spawnTerminal $ printf "%s %x" myEditor x

spawnDmenu :: String -> X ()
spawnDmenu x = do
    spawn $ printf "%s -h %s -fn %s -nb '%s' -nf '%s' -sb '%s' -sf '%s'" x "17" "Terminus-8" "#1d2021" "#ebdbb2" "#fabd2f" "#282828"
