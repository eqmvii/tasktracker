defmodule Mix.Tasks.Tasktracker.Greeting do
    use Mix.Task
  
    @shortdoc "Sends a greeting to us from Tasktracker"
  
    @moduledoc """
      This is where we would put any long form documentation or doctests.
    """
  
    def run(_args) do
      Mix.shell.info "Greetings from Tasktracker!"
    end
  
    # We can define other functions as needed here.
  end

# Run it with
# mix tasktracker.greeting