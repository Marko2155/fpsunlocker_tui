#!/bin/sh

fps=10000
robloxPath="/Applications/Roblox.app"

if [ ! -d $robloxPath ]; then
	$robloxPath = "~$robloxPath"

	if [ ! -d $robloxPath ]; then
		dialog --msgbox "Roblox could not be found." 0 0
		exit
	fi
fi

clientSettingsPath="$robloxPath/Contents/MacOS/ClientSettings"

if [ ! -d "$clientSettingsPath" ]; then
	mkdir $clientSettingsPath
fi

dialog --yesno "Would you like to use the Vulkan renderer? This will remove the FPS cap completely, but might break Roblox if you use an external monitor." 0 0

useVulkan = $?

case $useVulkan in
	1)
		clientSettings="{'DFIntTaskSchedulerTargetFps': $fps, 'FFlagDebugGraphicsDisableMetal': 'true', 'FFlagDebugGraphicsPreferVulkan': 'true'}"
		;;

	0)
		clientSettings="{'DFIntTaskSchedulerTargetFps': $fps}"
		;;

	255)
		exit
		;;
esac

echo $clientSettings > "$clientSettingsPath/ClientAppSettings.json"
dialog --msgbox "The FPS Unlocker (by @lanylow) has been installed in $robloxPath" 0 0
