import XMonad
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Spacing
import XMonad.Layout.Grid
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.NamedScratchpad
import System.IO
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified GHC.IO.Handle.Types as H

crLogHook h = do
	dynamicLogWithPP $ tryPP h

tryPP :: Handle -> PP
tryPP h = defaultPP
	{ ppOutput = hPutStrLn h
	, ppCurrent	    = dzenColor col1 col2 . pad . wrap space space
	, ppVisible	    = dzenColor col6 col2 . pad . wrap space space
	, ppHidden	    = dzenColor col6 col2 . pad . wrap space space
	, ppHiddenNoWindows = dzenColor col6 col2 . pad . wrap space space
	, ppWsSep	    = ""
	, ppSep		    = ""
	, ppLayout = wrap "^ca(1,xdotool key alt+space)" "^ca()" . dzenColor col1 col4 . pad . wrap space space .
	( \t -> case t of
	"Spacing 3 Grid"		-> dir_icon ++ "grid.xbm)"
	"Spacing 3 Tall"		-> dir_icon ++ "sptall.xbm)"
	"Mirror Spacing 3 Tall"	-> dir_icon ++ "mptall.xbm)"
	"Full"				-> dir_icon ++ "full.xbm)"
	)					
	, ppOrder  = \(ws:l:t:_) -> [l,ws]
	}

crWorkspace :: [String]
crWorkspace = clickable . (map dzenEscape) $ [
	  "Terminal"
	, "Browser"
	, "1"
	, "2"
	, "3"
	]
	where clickable l = [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
		(i,ws) <- zip [1..] l,
		let n = i ]

crKeys = [ ((mod1Mask,	xK_p), spawn dmenu_cr)
	, ((mod4Mask,	xK_q), spawn "killall dzen2; xmonad --recompile; xmonad --restart")
	, ((mod4Mask,	xK_o), spawn "opera-developer")
	, ((mod4Mask,	xK_v), spawn "vivaldi-snapshot")
	, ((mod4Mask,	xK_f), spawn "firefox-developer")
	, ((mod4Mask,   0xff61),spawn "sh /home/fox/.screenshot.sh")
	, ((mod4Mask .|. shiftMask, xK_Return), spawn "urxvt")
	, ((mod4Mask,	xK_Return), spawn "terminology")
	]

crLayout = avoidStruts $ smartBorders ( sTall ||| Mirror sTall ||| sGrid ||| Full )
	where 
	 sTall = spacing 3 $ Tall 1 (1/2) (1/2)
	 sGrid = spacing 3 $ Grid

crDocks = composeAll 
	[ className =? "Gimp" --> doFloat
	, title =? "urxvt" --> doCenterFloat
	, className =? "feh" --> doFloat
	]

crStartupHock = do
	spawnOnce "xfce4-power-manager &" 
	spawnOnce "conky &" 
	spawnOnce "nitrogen --restore &" 
	spawnOnce "fcitx-autostart &" 
	spawnOnce "volumeicon &" 
	spawnOnce "synclient Touchpadoff=1" 
	spawnOnce "xsetroot -cursor_name left_ptr" 
	spawnOnce "xmodmap ~/.Xmodmap" 
	spawnOnce "xbindkeys" 
	spawnOnce "terminology &" 
	spawnOnce "nm-applet &" 
	spawnOnce "evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)" 
	spawnOnce "compton &" 

main = do
	barAtas <- spawnPipe bar1
	barAtasKanan <- spawnPipe bar2
	xmonad $ defaultConfig
	 { manageHook = manageDocks <+> crDocks <+> manageHook defaultConfig
	 , layoutHook = crLayout
	 , handleEventHook = fullscreenEventHook
	 , modMask = mod4Mask
	 , workspaces = crWorkspace
	 , terminal = "terminology"
	 , focusedBorderColor = "#4c4c4c"
	 , normalBorderColor = col2
	 , borderWidth = 3
	 , startupHook = crStartupHock <+> setWMName "LG3D"
	 , logHook = crLogHook barAtas
	 } `additionalKeys` crKeys

space = "   "
col1 = "#fcfcfc"
col2 = "#2d2d2d"
col3 = "#d2d2d2"
col4 = "#9932CC"
col5 = "#010101"
col6 = "#9932CC"
bar1 = "dzen2 -p -ta l -e 'button3=' -fn 'Noto Sans-8' -fg '" ++ col1 ++ "' -bg '" ++ col2 ++ "' -h 24 -w 340"
bar2 = "sh /home/fox/.xmonad/scripts/dzen2info.sh"
dir_icon = "^ca(1,xdotool key alt+space)^i(/home/fox/.xmonad/icons/"
dmenu_cr = "dmenu_run -b -h 24 -l 10 -w 600 -x 433 -y 234 -nb '#2d2d2d' -sb '" ++ col4 ++ "'"
