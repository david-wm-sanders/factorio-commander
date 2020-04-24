_constants = require "_constants"
local xocore = {}
xocore._help = {}

xocore._help["xolist"] = "# Lists commands added by commander/xo"
function xocore.xolist(player, args)
  player.print("commander/xo is adding the following commands:", _constants.message_color)
  for command_name, commandmeta in pairs(xo._meta.get_commands()) do
    player.print(string.format("/%s %s", command_name, commandmeta.help), _constants.helping_color)
  end
end

return xocore
