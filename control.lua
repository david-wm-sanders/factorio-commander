xo = require "commander"

function in_table(item, t)
    for k, v in pairs(t) do
        if v == item or k == item then
            return true
        end
    end
    return false
end

script.on_load(function()
  -- Attempt to safely add all mod commands
  for command_name, help in pairs(xo._util.get_commands()) do
    if in_table(command_name, commands.commands) or in_table(command_name, commands.game_commands) then
      log(string.format("Unable to add '%s' command is it exists already", command_name))
    else
      -- Add the command at its function name
      commands.add_command(command_name, help, xo._util.command_handler)
      log(string.format("Added '%s' command at '/%s' successfully", command_name, command_name))
    end
  end
end)
