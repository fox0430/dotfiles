import XMonad
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
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.PerWorkspace
import XMonad.Layout.TwoPane
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.EZConfig
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

myTerminal  = "terminology"

blightUp    = 0x1008ff02
blightDown  = 0x1008ff03
volumeUp    = 0x1008ff13
volumeDown  = 0x1008ff11
volumeMute  = 0x1008ff12


myColor = xmobarColor "green" "" . wrap "<" ">"
myWorkspaces	= ["Term","Brows","1","2","3","4","5"]

moveWD			= myBorderWidth
resizeWD 		= 2*myBorderWidth
myBorderWidth	= 2
gapwidth  		= 4
gwU 			= 2
gwD 			= 1
gwL 			= 38
gwR 			= 37
myLayout        = spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
                    $ (ResizableTall 1 (1/201) (116/201) [])
                    ||| (TwoPane (1/201) (116/201))
                    ||| Simplest

myKeys			= [ ((mod4Mask,	xK_v), spawn "vivaldi-snapshot")

					-- Toggle layout (Fullscreen mode)
					, ((mod4Mask, xK_f)    , sendMessage ToggleLayout)
          -- Blightness contorl
          , ((0, blightUp), spawn "xbacklight -inc 5")
          , ((0, blightDown), spawn "xbacklight -dec 5")
          -- Volume contorl
          , ((0, volumeUp), spawn "amixer -M set Master 2%+")
          , ((0, volumeDown), spawn "amixer -M set Master 2%-")
          , ((0, volumeMute), spawn "amixer -D pulse set Master 1+ toggle")
	]

myManageHookFloat = composeAll
    [ className =? "Gimp"			--> doFloat
		, className =? "feh"			--> doFloat
		]