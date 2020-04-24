_constants = require "_constants"
local _meta = {}
_meta.command_table = {}

-- Function: split a string by specified delimeter
function split(s, delimiter)
  if type(s) ~= "string" then return {} end
  result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

function _meta.load_commands()
  -- Find commands
  for submodule_name, submodule in pairs(xo) do
    -- submodule if a table with its name starting with "xo"
    if type(submodule) == "table" and submodule_name:find("^xo") then
      for command_name, command in pairs(submodule) do
        -- command if function and function name doesn't start with an underscore (i.e. public) and function has submodule._cmd table entry
        if type(command) == "function" and not command_name:find("^_") then
          if in_table(command_name, submodule._cmd) then
            local submodule_cmd = submodule._cmd[command_name]
            -- Setup default _help and _path for command_name
            local _help = "# no.help.is.available"
            local _path = string.format("xo_%s.%s", submodule_name, command_name)
            -- TODO: get rid of this string check eventually by requiring all commands have ._cmd = {help=x, [path=y]}
            if type(submodule_cmd) == "string" then
              -- Use the string as the command help
              _help = submodule_cmd
            elseif type(submodule_cmd) == "table" then
              -- log(string.format("!!! %s._cmd['%s'] is a table", submodule_name, command_name)) -- DEBUG
              -- if help is set for submodule_cmd, overwrite default _help
              if in_table("help", submodule_cmd) then
                _help = submodule_cmd.help
              end
              -- if path is set for submodule_cmd, overwrite default _path
              if in_table("path", submodule_cmd) then
                _path = submodule_cmd.path
              end
            end
            log(string.format("INFO: loaded '/%s' command from '%s.%s' (function)", _path, submodule_name, command_name))
            _meta.command_table[submodule_name.."."..command_name] = {mod=submodule_name, path=_path, func=command, help=_help}
          else
            log(string.format("WARN: did not load '%s.%s' as it is not marked as a command", submodule_name, command_name))
          end
        end
      end
    end
  end
end

function _meta.command_handler(t)
  local player = game.players[t.player_index]
  local command_path = t.name
  local args = split(t.parameter, " ")

  log(string.format("INFO: '%s' ran '/%s %s'", player.name, command_path, t.parameter))
  -- Local ref _meta.command_table and construct a command_path to command_name map
  local _ct = xo._meta.command_table
  local _command_name_by_path = {}
  for command_name, commandmeta in pairs(_ct) do
    _command_name_by_path[commandmeta.path] = command_name
  end
  -- find the correct fully-qualified command_name (submodule_name.command_name)
  local command_name = _command_name_by_path[command_path]
  -- log(serpent.dump(_command_name_by_path))
  -- log("DEBUG: command_name="..command_name)

  if in_table(command_name, xo._meta.command_table) then
    -- Run directly as specified command_path directly maps function name
    xo._meta.command_table[command_name].func(player, args)
  else
    -- TODO: attempt to find the the command in the command_table by its path not its name
    log(string.format("ERROR: no command named '%s' in command_table", command_name))
    player.print(string.format("ERROR: no command named '%s' in command_table", command_name), _constants.failure_color)
  end
end

return _meta
