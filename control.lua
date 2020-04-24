xo = require "xo"

function in_table(item, t)
  for k, v in pairs(t) do
    if v == item or k == item then
      return true
    end
  end
  return false
end

script.on_load(function()
  xo._meta.load_commands()
  -- Attempt to safely add all mod commands
  for command_name, commandmeta in pairs(xo._meta.command_table) do
    if in_table(command_name, commands.commands) or in_table(command_name, commands.game_commands) then
      log(string.format("ERROR: Unable to add '/%s' command is it exists already", command_name))
    else
      -- Add the command at its function name
      commands.add_command(commandmeta.path, commandmeta.help, xo._meta.command_handler)
      log(string.format("INFO: Added '/%s' command from '%s.%s' successfully", commandmeta.path, "todo_submodule_path", command_name))
    end
  end
end)
