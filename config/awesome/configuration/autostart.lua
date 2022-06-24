local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.check_if_running("picom --experimental-backends", nil, function()
		awful.spawn("picom --experimental-backends --config " .. config_dir .. "configuration/picom.conf", false)
	end)
	--- Music Server
	helpers.run_once_pgrep("mpd")
	helpers.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	--- Other stuff
	helpers.run_once_grep("blueman-applet")
	helpers.run_once_grep("nm-applet")

	-- with shell
	awful.spawn("dropbox")
	awful.spawn("flameshot")


end

autostart_apps()

