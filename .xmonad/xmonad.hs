-- Optimazied for 16:9 display

import XMonad
import XMonad.ManageHook
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.FloatKeys
import XMonad.Layout
import XMonad.Layout.DragPane
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import Graphics.X11.ExtraTypes.XF86
import System.IO

main :: IO()

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad =<< statusBar
		"xmobar"
			xmobarPP
			toggleStrutsKey
			myConfig
			{ logHook = dynamicLogWithPP $ xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppTitle = myColor
				}
			}

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )

myConfig = ewmh defaultConfig
    { terminal							= myTerminal 
    , modMask								= mod4Mask
    , borderWidth						= myBorderWidth
		, focusFollowsMouse			= True
		, workspaces						= myWorkspaces
		, startupHook						= setWMName "LG3D"
		, manageHook						= manageDocks <+> myManageHookFloat <+> manageHook defaultConfig
		, handleEventHook				= fullscreenEventHook
		, logHook 							= dynamicLogWithPP $ xmobarPP
    , layoutHook						= avoidStruts $ ( toggleLayouts (noBorders Full) $ myLayout)
		, normalBorderColor			= "#333333"
    , focusedBorderColor		= "#cd8b00"
    } `additionalKeys` myKeys

myTerminal    = "alacritty"

-- key code
blightUp      = 0x1008ff02
blightDown    = 0x1008ff03
volumeUp      = 0x1008ff13
volumeDown    = 0x1008ff11
volumeMute    = 0x1008ff12
printScreen   = 0xff61


myColor       = xmobarColor "green" "" . wrap "<" ">"
myWorkspaces  = ["Term","Brows","1","2","3","4","5"]

moveWD        = myBorderWidth
resizeWD      = 2*myBorderWidth
myBorderWidth	= 2
gapwidth  		= 4
gwU           = 2
gwD           = 1
gwL           = 38
gwR           = 37
myLayout      = spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
                  $ (ResizableTall 1 (1/201) (116/201) [])
                  ||| Mirror (Tall 1 (3/100) (3/5))
                  ||| ThreeCol 1 (3/100) (1/2)

myKeys			  = [ ((mod4Mask,	xK_v), spawn "vivaldi-snapshot")
                , ((mod4Mask, xK_Return), spawn "alacritty")
                , ((mod4Mask .|. shiftMask, xK_Return), spawn "sh ~/.xmonad/urxvt_float.sh &")

					      -- Toggle layout (Fullscreen mode)
					      , ((mod4Mask, xK_f)    , sendMessage ToggleLayout)
                -- Blightness contorl
                , ((0, blightUp), spawn "xbacklight -inc 5")
                , ((0, blightDown), spawn "xbacklight -dec 5")
                -- Volume contorl
                , ((0, volumeUp), spawn "amixer -M set Master 2%+")
                , ((0, volumeDown), spawn "amixer -M set Master 2%-")
                , ((0, volumeMute), spawn "amixer set Master toggle")
                -- Swap window
                , ((mod4Mask .|. shiftMask, xK_period), windows W.swapDown)
                , ((mod4Mask .|. shiftMask, xK_comma), windows W.swapUp)
                -- Screen shot
                , ((0, printScreen), spawn "/bin/bash ~/.xmonad/ss.sh &")

  ]

myManageHookFloat   =   composeAll
    [ className     =?  "Gimp"			   --> doFloat
		, className     =?  "feh"          --> doFloat
    , title         =?  "urxvt_float"  --> doLeftFloat
    ]

    where
      doLeftFloat = customFloating $ W.RationalRect (0/6) (3.3/6) (1.7/4) (2.7/6)   --x, y, width, hight
