_constants = require "_constants"
local xowiki = {}
xowiki._help = {}

xowiki._help["tp"] = "<x> <y> # Teleport"
function xowiki.tp(player, args)
  -- TODO: implement a safe teleport - build island if location is on water, remove natural entities that collide location, etc
  player.print("not.implemented.yet", _constants.failure_color)
  -- TODO: list warps
end

xowiki._help["sandbox-on"] = "# Remove player character"
-- TODO: convert player to sandbox mode
xowiki._help["sandbox-off"] = "# Create player character"
-- TODO: convert player from sandbox mode
xowiki._help["make-zoo"] = "# Build a biter zoo"
-- TODO: make a zoo for biters with cliffs, rock formations, lakes, etc
-- xowiki._help["make-patch"] = "# Make a patch of resources"
xowiki._help["mine-faster"] = "# Mine faster"
xowiki._help["mine-normal"] = "# Mine normally"
xowiki._help["craft-faster"] = "# Craft faster"
xowiki._help["craft-normal"] = "# Craft normally"
xowiki._help["research-finish"] = "# Research all tech"
xowiki._help["research-forget"] = "# Forget all researched tech"
xowiki._help["railblocks-show"] = "# Show railblocks"
xowiki._help["railblocks-hide"] = "# Hide railblocks"
xowiki._help["armorup"] = "# Configure power armor"
xowiki._help["chartmap-player"] = "# Reveal the map around the player"
xowiki._help["chartmap-center"] = "# Reveal the map around the start position"
xowiki._help["chartmap-all"] = "# Reveal all of the generated map"
xowiki._help["daylight-savings-on"] = "# Enable eternal day"
xowiki._help["daylight-savings-off"] = "# Disable eternal day"
xowiki._help["gamespeed"] = "<speed> # Set the game speed"
xowiki._help["difficulty-normal"] = "# Set the recipe and tech difficulty to normal"
xowiki._help["difficulty-expensive"] = "# Set the recipe and tech difficulty to expensive"
xowiki._help["pollution-clear"] = "# Clear all pollution"
xowiki._help["resource-add"] = "# Add a patch of resources"
xowiki._help["resource-del"] = "# Remove patches of resources"
xowiki._help["let-there-be-oil"] = "# Add new oil patches"
xowiki._help["count-entities"] = "# Count entities"
xowiki._help["flush-pipes"] = "# Flush all fluids from pipes, underground pipes, and pumps"
xowiki._help["cliffs-on"] = "# Enable cliff generation"
xowiki._help["cliffs-off"] = "# Disable cliff generation"
xowiki._help["cliffs-del"] = "# Remove all cliffs"
xowiki._help["decoratives-be-gone"] = "# Destroy all decoratives"
xowiki._help["bitercide"] = "# Kill all biters, bases, and worms"

return xowiki
