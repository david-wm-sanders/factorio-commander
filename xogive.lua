_constants = require "_constants"
local xogive = {}
xogive._help = {}

xogive._help["give"] = "<item> <count> # Give player count of item"
function xogive.give(player, args)
  if table_size(args) ~= 2 then
    log(string.format("WARN: 'xo.give': incorrect parameter count: takes 2, given %i", table_size(args)))
    player.print("Incorrect parameter count", _constants.failure_color)
  else
    local item_name = args[1]
    local count = args[2]
    if game.item_prototypes[item_name] ~= nil then
      player.insert({name=item_name, count=count})
      player.print(string.format("%i %s issued", count, item_name), _constants.success_color)
    -- TODO: add elseif that checks an item shortcut mapping
    else
      player.print(string.format("Item '%s' doesn't exist as primitive or shortcut", item_name), _constants.failure_color)
    end
  end
end

return xogive
