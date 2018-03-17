defmodule TasktrackerWeb.TodoView do
    use TasktrackerWeb, :view

    def name_shorten(todo_name) do
      cond do
        String.length(todo_name) > 10 ->
          String.slice(todo_name, 0..10) <> "..."
        true ->
          todo_name        
      end
    end
  end