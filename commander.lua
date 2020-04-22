local xo = {}
xo._help = {}
xo._meta = require "_meta"

-- Configure colours for use in command output
local failure_color = {1, 0, 0}
local success_color = {0, 1, 0}
local message_color = {0.7, 0.7, 0.7}
local helping_color = {120, 200, 220}


-- XO USER FUNCTIONS -----------------------------------------------------------
xo._help["xolist"] = "# Lists commands added by commander/xo"
function xo.xolist(player, args)
  player.print("commander/xo is adding the following commands:", message_color)
  for command_name, help in pairs(xo._meta.get_commands()) do
    player.print(string.format("/%s %s", command_name, help), helping_color)
  end
end

xo._help["reloadmods"] = "# Reload all mods"
function xo.reloadmods(player, args)
  log("INFO: 'xo.reloadmods': Reloading mods...")
  player.print("Reloading mods...", message_color)
  game.reload_mods()
  player.print("All mods reloaded successfully", success_color)
end

xo._help["give"] = "<item> <count> # Give player count of item"
function xo.give(player, args)
  if table_size(args) ~= 2 then
    log(string.format("WARN: 'xo.give': incorrect parameter count: takes 2, given %i", table_size(args)))
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

xo._help["warpdel"] = "<name> # Remove a warp destination"
function xo.warpdel(player, args)
  -- TODO: delete a warp by name
  player.print("not.implemented.yet", failure_color)
end

xo._help["tp"] = "<x> <y> <z> # Teleport"
-- TODO: implement a safe teleport - build island if location is on water, remove natural entities that collide location, etc
xo._help["sandbox-on"] = "# Remove player character"
-- TODO: convert player to sandbox mode
xo._help["sandbox-off"] = "# Create player character"
-- TODO: convert player from sandbox mode
xo._help["make-zoo"] = "# Build a biter zoo"
-- TODO: make a zoo for biters with cliffs, rock formations, lakes, etc
-- xo._help["make-patch"] = "# Make a patch of resources"
xo._help["mine-faster"] = "# Mine faster"
xo._help["mine-normal"] = "# Mine normally"
xo._help["craft-faster"] = "# Craft faster"
xo._help["craft-normal"] = "# Craft normally"
xo._help["research-finish"] = "# Research all tech"
xo._help["research-forget"] = "# Forget all researched tech"
xo._help["railblocks-show"] = "# Show railblocks"
xo._help["railblocks-hide"] = "# Hide railblocks"
xo._help["armorup"] = "# Configure power armor"
xo._help["chartmap-player"] = "# Reveal the map around the player"
xo._help["chartmap-center"] = "# Reveal the map around the start position"
xo._help["chartmap-all"] = "# Reveal all of the generated map"
xo._help["daylight-savings-on"] = "# Enable eternal day"
xo._help["daylight-savings-off"] = "# Disable eternal day"
xo._help["gamespeed"] = "<speed> # Set the game speed"
xo._help["difficulty-normal"] = "# Set the recipe and tech difficulty to normal"
xo._help["difficulty-expensive"] = "# Set the recipe and tech difficulty to expensive"
xo._help["pollution-clear"] = "# Clear all pollution"
xo._help["resource-add"] = "# Add a patch of resources"
xo._help["resource-del"] = "# Remove patches of resources"
xo._help["let-there-be-oil"] = "# Add new oil patches"
xo._help["count-entities"] = "# Count entities"
xo._help["flush-pipes"] = "# Flush all fluids from pipes, underground pipes, and pumps"
xo._help["cliffs-on"] = "# Enable cliff generation"
xo._help["cliffs-off"] = "# Disable cliff generation"
xo._help["cliffs-del"] = "# Remove all cliffs"
xo._help["decoratives-be-gone"] = "# Destroy all decoratives"
xo._help["bitercide"] = "# Kill all biters, bases, and worms"

-- Return xo to allow control to import this as a module
return xo
