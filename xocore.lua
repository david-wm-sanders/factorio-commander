_constants = require "_constants"
local xocore = {}
xocore._help = {}

xocore._help["xolist"] = "# Lists commands added by commander/xo"
function xocore.xolist(player, args)
  player.print("commander/xo is adding the following commands:", _constants.message_color)
  for command_name, commandmeta in pairs(xo._meta.command_table) do
    player.print(string.format("/%s %s", command_name, commandmeta.help), _constants.helping_color)
  end
end

xocore._help["reloadmods"] = "# Reload all mods"
function xocore.reloadmods(player, args)
  log("INFO: 'xo.reloadmods': Reloading mods...")
  player.print("Reloading mods...", _constants.message_color)
  game.reload_mods()
  player.print("All mods reloaded successfully", _constants.success_color)
end

return xocore
