local _meta = {}

-- Function: split a string by specified delimeter
function split(s, delimiter)
  if type(s) ~= "string" then return {} end
  result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

function _meta.get_commands()
  local t = {}
  for k, f in pairs(xo) do
    log(string.format("DEBUG: (%s) %s: %s", type(f), k, f))
    if type(f) == "function" then
      t[k] = xo._help[k]
    end
  end
  return t
end

function _meta.command_handler(t)
  local command_name = t.name
  local player = game.players[t.player_index]
  local args = split(t.parameter, " ")
  log(string.format("INFO: '%s' ran '/%s %s'", player.name, command_name, t.parameter))
  if in_table(command_name, xo) then
    xo[command_name](player, args)
  end
end

return _meta
