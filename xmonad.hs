import XMonad
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.FloatKeys
import XMonad.Layout
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
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
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

myConfig = defaultConfig
    { terminal    		= myTerminal
    , modMask     		= myModMask
    , borderWidth 		= myBorderWidth
	, focusFollowsMouse	= True
	, workspaces		= myWorkspaces
	, startupHook		= setWMName "LG3D"
	, manageHook 		= manageDocks <+> manageHook defaultConfig
	, handleEventHook   = fullscreenEventHook
	, logHook 			= dynamicLogWithPP $ xmobarPP
	, layoutHook		= avoidStruts $ ( toggleLayouts (noBorders Full)
										$ onWorkspace "3" simplestFloat $ myLayout)
	, normalBorderColor  = "#333333"
    , focusedBorderColor = "#cd8b00"
    } `additionalKeys` myKeys

myTerminal    	= "terminology"
myModMask     	= mod4Mask 

myColor = xmobarColor "green" "" . wrap "<" ">"
myWorkspaces	= ["Terminal","Browser","1","2","3"]

moveWD			= myBorderWidth
resizeWD 		= 2*myBorderWidth
myBorderWidth	= 2
gapwidth  		= 4
gwU 			= 2
gwD 			= 1
gwL 			= 38
gwR 			= 37
myLayout 		= spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
					$ (ResizableTall 1 (1/204) (119/204) [])
					||| (TwoPane (1/204) (119/204))
					||| Simplest

--myStartupHook	= do
--	spawnOnce "terminology &"
--	spawnOnce "volumeicon &" 
--	spawnOnce "xsetroot -cursor_name left_ptr"
--	spawnOnce "evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)" 
--	spawnOnce "compton &"
--	spawnOnce "nm-applet &"
--	spawnOnce "fcitx &"
--	spawnOnce "nitrogen --restore &"
--	spawnOnce "xfce4-power-manager &"

myKeys			= [ ((mod4Mask,	xK_v), spawn "vivaldi-snapshot")

					-- Toggle layout (Fullscreen mode)
					, ((mod4Mask, xK_f)    , sendMessage ToggleLayout)
	]
