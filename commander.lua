local xo = {}
xo._util = {}
xo._help = {}


-- Configure colours for use in command output
local failure_color = {1, 0, 0}
local success_color = {0, 1, 0}
local message_color = {0.7, 0.7, 0.7}
local helping_color = {120, 200, 240}

-- HIGH LEVEL INTERNAL UTILITY FUNCTIONS ---------------------------------------
-- Function: split a string by specified delimeter
function split(s, delimiter)
  if type(s) ~= "string" then return {} end
  result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

-- XO UTILITY FUNCTIONS --------------------------------------------------------
function xo._util.get_commands()
  local t = {}
  for k, f in pairs(xo) do
    if type(f) == "function" then
      t[k] = xo._help[k]
    end
  end
  return t
end

function xo._util.command_handler(t)
  local command_name = t.name
  local player = game.players[t.player_index]
  local args = split(t.parameter, " ")
  if in_table(command_name, xo) then
    xo[command_name](player, args)
  end
end


-- XO USER FUNCTIONS -----------------------------------------------------------
xo._help["xolist"] = "# Lists commands added by commander/xo"
function xo.xolist(player, args)
  player.print("commander/xo is adding the following commands:", message_color)
  for command_name, help in pairs(xo._util.get_commands()) do
    player.print(string.format("/%s %s", command_name, help), helping_color)
  end
end

xo._help["reloadmods"] = "# Reload all mods"
function xo.reloadmods(player, args)
  player.print("Reloading all mods...", message_color)
  game.reload_mods()
  player.print("All mods reloaded successfully", success_color)
end

xo._help["give"] = "<item> <count> # Give player count of item"
function xo.give(player, args)
  if table_size(args) ~= 2 then
    player.print("Incorrect parameter count", failure_color)
  else
    local item_name = args[1]
    local count = args[2]
    if game.item_prototypes[item_name] ~= nil then
      player.insert({name=item_name, count=count})
      player.print(string.format("%i %s issued", count, item_name), success_color)
    -- TODO: add elseif that checks an item shortcut mapping
    else
      player.print(string.format("Item '%s' doesn't exist as primitive or shortcut", item_name), failure_color)
    end
  end
end

xo._help["givepack"] = "<packname> [<count>] # Gives player pack(s) by packname"
function xo.givepack(player, args)
  player.print("not.implemented.yet", failure_color)
  -- TODO: create a set of packs that container groupings of items that are commonly used together
  -- example packs: rail: rail, signals, train stops; belt: belt, duct, splitter; pipes: pipe, underground pipe, pump
  -- TODO: match a pack by packname or fail
  -- TODO: get count of items in pack already in player inventory
  -- TODO: calculate item_diff as item_pack_count - item_inventory_count
  -- TODO: if item_diff > 0, add item_diff pack items to player inventory
  -- TODO: output stats on what was added
end

xo._help["warp"] = "<name> # Warp to a destination created with /warpset"
function xo.warp(player, args)
  player.print("not.implemented.yet", failure_color)
  -- TODO: match a warp by name or fail
  -- TODO: warp player to warp coords
end

xo._help["warplist"] = "# List destination names created with /warpset"
function xo.warplist(player, args)
  player.print("not.implemented.yet", failure_color)
  -- TODO: list warps
end

xo._help["warpset"] = "<name> [<x> <y> <z>] # Create a warp destination"
function xo.warpset(player, args)
  -- TODO: if no xyz, create a warp called <name> at player location
  -- TODO: if xyz provided:
  ---- TODO: check collisions for xyz:
  ---- TODO: if xyz collides with non-player built object (tree, rock, biter base):
  ------ TODO: delete entity and build warp:
  -------- TODO: select a random warp blueprint/marker tiling and set tiles in world to build
  ---- TODO: else fail
  player.print("not.implemented.yet", failure_color)
end

xo._help["warpdel"] = "<name> # Delete a warp destination"
function xo.warpdel(player, args)
  -- TODO: delete a warp by name
  player.print("not.implemented.yet", failure_color)
end

xo._help["sandbox"] = "# Remove player character"
xo._help["unsandbox"] = "# Create player character"
xo._help["mkzoo"] = "# Build a biter zoo"

-- Return xo to allow control to import this as a module
return xo
