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
  local command_table = {}
  -- TODO: move list and reloadmods into embedded "core" submodule in xo.lua and then get rid of this top level check mess
  -- First pass for top-level xo commands in order to ensure that they are added first
  for command_name, command in pairs(xo) do
    -- If v is a function where its name doesn't start with an underscore (i.e. public), form the command
    if type(command) == "function" and not command_name:find("^_") then
      log(string.format("DEBUG: found '/%s' command at '%s' (function)", "todo_command_path", command_name))
      command_table[command_name] = {func=command, help=xo._help[command_name]}
    end
  end
  -- Second pass for xo submodule commands
  for submodule_name, submodule in pairs(xo) do
    -- If v is a table, representing a submodule, where its name starts with "xo"
    if type(submodule) == "table" and submodule_name:find("^xo") then
      for command_name, command in pairs(submodule) do
        -- TODO: check in_table(command_name, submodule.command_path): if true - use the submodule.command_path; if false - generate command path as "xo_{command_name}"
        -- TODO: adapt control.lua etc
        if type(command) == "function" and not command_name:find("^_") then
          log(string.format("DEBUG: found '/%s' command at '%s.%s' (function)", "todo_command_path", submodule_name, command_name))
          command_table[command_name] = {func=command, help=submodule._help[command_name]}
        end
      end
    end
  end
  return command_table
end

function _meta.command_handler(t)
  -- TODO: move command_table get up here
  local player = game.players[t.player_index]
  local args = split(t.parameter, " ")
  -- TODO: check for t.name in command_table `in_table(t.name, command_table)`
  ---- TODO: yes: run function associated with command_name directly
  ---- TODO: no: find command_table[command_name] where command_table[command_name].pref == t.name
  local command_name = t.name
  log(string.format("INFO: '%s' ran '/%s %s'", player.name, command_name, t.parameter))
  if in_table(command_name, xo) then
    log(string.format("DEBUG: Running '%s' from xo", command_name))
    xo[command_name](player, args)
    return
  else
    log(string.format("WARN: '/%s' command not mapped properly", command_name))
    player.print(string.format("WARN: '/%s' command not mapped properly", command_name))
  end
  -- for command_name, commandmeta in pairs(xo._meta.get_commands()) do
  --   log(string.format("DEBUG: '%s' (path='/todo', help='%s')", command_name, commandmeta.help))
  -- end
  command_table = xo._meta.get_commands()
  if in_table(command_name, command_table) then
    command_table[command_name].func(player, args)
  end
end

return _meta
