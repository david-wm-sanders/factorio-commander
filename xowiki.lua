_constants = require "_constants"
local xowiki = {}
xowiki._cmd = {}

xowiki._cmd["tp"] = "<x> <y> # Teleport"
function xowiki.tp(player, args)
  -- TODO: implement a safe teleport - build island if location is on water, remove natural entities that collide location, etc
  player.print("not.implemented.yet", _constants.failure_color)
  -- TODO: list warps
end

xowiki._cmd["sandbox-on"] = "# Remove player character"
-- TODO: convert player to sandbox mode
xowiki._cmd["sandbox-off"] = "# Create player character"
-- TODO: convert player from sandbox mode
xowiki._cmd["make-zoo"] = "# Build a biter zoo"
-- TODO: make a zoo for biters with cliffs, rock formations, lakes, etc
-- xowiki._cmd["make-patch"] = "# Make a patch of resources"
xowiki._cmd["mine-faster"] = "# Mine faster"
xowiki._cmd["mine-normal"] = "# Mine normally"
xowiki._cmd["craft-faster"] = "# Craft faster"
xowiki._cmd["craft-normal"] = "# Craft normally"
xowiki._cmd["research-finish"] = "# Research all tech"
xowiki._cmd["research-forget"] = "# Forget all researched tech"
xowiki._cmd["railblocks-show"] = "# Show railblocks"
xowiki._cmd["railblocks-hide"] = "# Hide railblocks"
xowiki._cmd["armorup"] = "# Configure power armor"
xowiki._cmd["chartmap-player"] = "# Reveal the map around the player"
xowiki._cmd["chartmap-center"] = "# Reveal the map around the start position"
xowiki._cmd["chartmap-all"] = "# Reveal all of the generated map"
xowiki._cmd["daylight-savings-on"] = "# Enable eternal day"
xowiki._cmd["daylight-savings-off"] = "# Disable eternal day"
xowiki._cmd["gamespeed"] = "<speed> # Set the game speed"
xowiki._cmd["difficulty-normal"] = "# Set the recipe and tech difficulty to normal"
xowiki._cmd["difficulty-expensive"] = "# Set the recipe and tech difficulty to expensive"
xowiki._cmd["pollution-clear"] = "# Clear all pollution"
xowiki._cmd["resource-add"] = "# Add a patch of resources"
xowiki._cmd["resource-del"] = "# Remove patches of resources"
xowiki._cmd["let-there-be-oil"] = "# Add new oil patches"
xowiki._cmd["count-entities"] = "# Count entities"
xowiki._cmd["flush-pipes"] = "# Flush all fluids from pipes, underground pipes, and pumps"
xowiki._cmd["cliffs-on"] = "# Enable cliff generation"
xowiki._cmd["cliffs-off"] = "# Disable cliff generation"
xowiki._cmd["cliffs-del"] = "# Remove all cliffs"
xowiki._cmd["decoratives-be-gone"] = "# Destroy all decoratives"
xowiki._cmd["bitercide"] = "# Kill all biters, bases, and worms"

return xowiki
