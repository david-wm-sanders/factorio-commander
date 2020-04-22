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
  -- First pass for top-level xo commands in order to ensure that they are added first
  for k, v in pairs(xo) do
    -- If v is a function where its name doesn't start with an underscore (i.e. public), form the command
    if type(v) == "function" and not k:find("^_") then
      log(string.format("DEBUG: finding help for '%s' command (function)", k))
      t[k] = xo._help[k]
    end
  end
  -- Second pass for xo submodule commands
  for k, v in pairs(xo) do
    -- If v is a table, representing a submodule, where its name starts with "xo"
    if type(v) == "table" and k:find("^xo") then
      for ki, vi in pairs(v) do
        if type(vi) == "function" then
          if not k:find("^_") then
            log(string.format("DEBUG: finding help for '%s.%s' command (function)", k, ki))
            t[ki] = v._help[ki]
          end
        end
      end
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
  -- TODO: Fix to call functions in xo submodules correctly
  -- TODO: call get_commands, find command in commands or fail, call command if found
  else
    log(string.format("WARN: '/%s' command not mapped properly", command_name))
    player.print(string.format("WARN: '/%s' command not mapped properly", command_name))
  end
end

return _meta
