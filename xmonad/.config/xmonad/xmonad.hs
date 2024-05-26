------------------------------------------------------------------------
-- Imports

-- Base
import XMonad
import System.Exit
import qualified XMonad.StackSet as W

-- Dataq
import Data.Monoid
import qualified Data.Map as M

-- Layouts
import XMonad.Layout.ThreeColumns

-- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.WindowSwallowing

-- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Hacks (javaHack, windowedFullscreenFixEventHook)
import XMonad.Util.NamedScratchpad


------------------------------------------------------------------------
-- Main options

myTerminal = "st"

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

mySwallowClasses = ["St", "XTerm"]

myBorderWidth = 1
myNormalBorderColor  = "#888888"
myFocusedBorderColor = "#ff0000"


------------------------------------------------------------------------
-- Scratchpads

myScratchPads =
  [ NS "terminal" "st -c scratchpad" (className =? "scratchpad") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ]


------------------------------------------------------------------------
-- Key action functions

toggleFloat :: Window -> X ()
toggleFloat = \w -> do
  floating <- gets (M.member w . W.floating . windowset)
  if floating
    then windows $ W.sink w
    else withFocused float


------------------------------------------------------------------------
-- Key bindings

myKeys = \c -> mkKeymap c $
  -- Launching
  [ ("M-<Return>", spawn $ terminal c)
  , ("M-p", spawn "dmenu_run")

  -- Layouts
  , ("M-<Tab>", sendMessage NextLayout)
  , ("M-t", sendMessage $ JumpToLayout "tall")
  , ("M-w", sendMessage $ JumpToLayout "wide")
  , ("M-m", sendMessage $ JumpToLayout "monocle")

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
  , ("M-S-f", sendMessage $ T.Toggle "monocle")
  , ("M-S-<Space>", withFocused $ toggleFloat)

  -- Master amount
  , ("M-i", sendMessage (IncMasterN 1))
  , ("M-d", sendMessage (IncMasterN (-1)))

  -- Scratchpads
  , ("M-'", namedScratchpadAction myScratchPads "terminal")

  -- Window spacing
  , ("M-S-i", incWindowSpacing 4)
  , ("M-S-d", decWindowSpacing 4)

  -- Session
  , ("M-S-<Delete>", io (exitWith ExitSuccess))
  , ("M-<Delete>", spawn "xmonad --recompile; xmonad --restart")
  ] ++

  -- View workspace N
  [ ("M-" ++ show i, windows $ W.greedyView (myWorkspaces !! (i-1)))
  | i <- [1..9]
  ] ++

  -- Shift window to workspace N
  [ ("M-S-" ++ show i, windows $ W.shift (myWorkspaces !! (i-1)))
  | i <- [1..9]
  ]


------------------------------------------------------------------------
-- Mouse bindings

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
  -- Set the window to floating mode and move by dragging
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
  -- Raise the window to the top of the stack
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
  -- Set the window to floating mode and resize by dragging
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
  ]


------------------------------------------------------------------------
-- Layouts

tall =
  renamed [Replace "tall"]
  $ spacing 4
  $ Tall 1 (3/100) (1/2)
wide =
  renamed [Replace "wide"]
  $ Mirror tall
monocle =
  renamed [Replace "monocle"]
  $ spacing 4
  $ Full
threeCol =
  renamed [Replace "threeCol"]
  $ spacing 4
  $ ThreeCol 1 (3/100) (1/2)

myLayout =
  onWorkspaces ["4", "5"] monocle
  $ T.toggleLayouts monocle
  $ tall ||| wide ||| monocle ||| threeCol


------------------------------------------------------------------------
-- Window rules


myManageHook = composeAll
  [ className =? "MPlayer"        --> doFloat
  , className =? "Gimp"           --> doFloat
  , resource  =? "desktop_window" --> doIgnore
  , resource  =? "kdesktop"       --> doIgnore
  , isFullscreen --> doFullFloat
  ] <+> namedScratchpadManageHook myScratchPads <+> insertPosition End Newer


------------------------------------------------------------------------
-- Event handling

myEventHook =
  swallowEventHook (foldr1 (<||>) $ map (\name -> className =? name) mySwallowClasses) (return True)
  -- Fixes
  <> windowedFullscreenFixEventHook


------------------------------------------------------------------------
-- Status bars and logging

myLogHook = return ()


------------------------------------------------------------------------
-- Main

-- Static options
myModMask = mod4Mask
myFocusFollowsMouse = True
myClickJustFocuses = False

main :: IO ()
main = do
  xmonad $ def
    { terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor

    , keys               = myKeys
    , mouseBindings      = myMouseBindings

    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , logHook            = myLogHook
    }
