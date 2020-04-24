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
            -- local submodule_cmd = submodule._cmd[command_name]
            ---- TODO: check to see if submodule._cmd[command_name] is a table or string
            -- Setup default _help and _path for command_name
            local _help = "# no.help.is.available"
            local _path = string.format("xo.%s.%s", submodule_name, command_name)
            if type(submodule._cmd[command_name]) == "string" then
              -- Use the string as the command help
              _help = submodule._cmd[command_name]
            elseif type(submodule._cmd[command_name]) == "table" then
              log(string.format("!!! %s._cmd['%s'] is a table", submodule_name, command_name))
              -- if in
            end
            -- if type(submodule._cmd[])
            ---- TODO: if table attempt to get help and path params and put in command table
            ------ TODO: check in_table(command_name, submodule.command_path): if true - use the submodule.command_path; if false - generate command path as "xo_{module}.{command_name}"
            ------ TODO: adapt control.lua etc
            ---- TODO: if string treat it as help and create the path as 'xo_'
            log(string.format("INFO: loaded '/%s' command at '%s.%s' (function)", "todo_command_path", submodule_name, command_name))
            _meta.command_table[command_name] = {func=command, help=_help}
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
  local args = split(t.parameter, " ")
  -- TODO: check for t.name in command_table `in_table(t.name, command_table)`
  ---- TODO: yes: run function associated with command_name directly
  ---- TODO: no: find command_table[command_name] where command_table[command_name].pref == t.name
  local command_name = t.name
  log(string.format("INFO: '%s' ran '/%s %s'", player.name, command_name, t.parameter))

  -- for command_name, commandmeta in pairs(xo._meta.command_table) do
  --   log(string.format("DEBUG: '%s' (path='/todo', help='%s')", command_name, commandmeta.help))
  -- end
  if in_table(command_name, xo._meta.command_table) then
    xo._meta.command_table[command_name].func(player, args)
  end
end

return _meta
