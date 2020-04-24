_constants = require "_constants"
local xowarp = {}
xowarp._cmd = {}

xowarp._cmd["warp"] = "<name> # Warp to a destination created with /warpset"
function xowarp.warp(player, args)
  player.print("not.implemented.yet", _constants.failure_color)
  -- TODO: match a warp by name or fail
  -- TODO: warp player to warp coords
end

xowarp._cmd["warplist"] = "# List destination names created with /warpset"
function xowarp.warplist(player, args)
  player.print("not.implemented.yet", _constants.failure_color)
  -- TODO: list warps
end

xowarp._cmd["warpset"] = "<name> [<x> <y> <z>] # Create a warp destination"
function xowarp.warpset(player, args)
  -- TODO: if no xyz, create a warp called <name> at player location
  -- TODO: if xyz provided:
  ---- TODO: check collisions for xyz:
  ---- TODO: if xyz collides with non-player built object (tree, rock, biter base):
  ------ TODO: delete entity and build warp:
  -------- TODO: select a random warp blueprint/marker tiling and set tiles in world to build
  ---- TODO: else fail
  player.print("not.implemented.yet", _constants.failure_color)
end

xowarp._cmd["warpdel"] = "<name> # Remove a warp destination"
function xowarp.warpdel(player, args)
  -- TODO: delete a warp by name
  player.print("not.implemented.yet", _constants.failure_color)
end

return xowarp
