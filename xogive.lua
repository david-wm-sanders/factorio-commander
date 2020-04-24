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

xogive._help["givepack"] = "<packname> [<count>] # Gives player pack(s) by packname"
function xogive.givepack(player, args)
  player.print("not.implemented.yet", _constants.failure_color)
  -- TODO: create a set of packs that container groupings of items that are commonly used together
  -- example packs: rail: rail, signals, train stops; belt: belt, duct, splitter; pipes: pipe, underground pipe, pump
  -- TODO: match a pack by packname or fail
  -- TODO: get count of items in pack already in player inventory
  -- TODO: calculate item_diff as item_pack_count - item_inventory_count
  -- TODO: if item_diff > 0, add item_diff pack items to player inventory
  -- TODO: output stats on what was added
end

return xogive
