local xo = {}
xo._util = {}
xo._help = {}


-- Configure colours for use in command output
local failure_color = {1, 0, 0}
local success_color = {0, 1, 0}

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
xo._help["give"] = "<item> <count>"
function xo.give(player, args)
  if table_size(args) ~= 2 then
    player.print("Incorrect parameter count", failure_color)
  else
    local item_name = args[1]
    local count = args[2]
    if game.item_prototypes[item_name] ~= nil then
      player.insert({name=item_name, count=count})
      player.print(string.format("%i %s issued", count, item_name), success_color)
    else
      player.print(string.format("Item '%s' doesn't exist", item_name), failure_color)
    end
  end
end


-- Return xo to allow control to import this as a module
return xo
