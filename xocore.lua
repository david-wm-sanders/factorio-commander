_constants = require "_constants"
local xocore = {}
xocore._cmd = {}

xocore._cmd["xolist"] = {path="xolist", help="# Lists commands added by commander/xo"}
function xocore.xolist(player, args)
  player.print("commander/xo is adding the following commands:", _constants.message_color)
  for command_name, commandmeta in pairs(xo._meta.command_table) do
    player.print(string.format("[%s] /%s %s", command_name, commandmeta.path, commandmeta.help), _constants.helping_color)
  end
end

xocore._cmd["reloadmods"] = {path="xoreload", help="# Reload all mods (including, obvs, commander/xo)"}
function xocore.reloadmods(player, args)
  log("INFO: 'xocore.reloadmods': Reloading mods...")
  player.print("Reloading mods...", _constants.message_color)
  game.reload_mods()
  player.print("All mods reloaded successfully", _constants.success_color)
end

return xocore
