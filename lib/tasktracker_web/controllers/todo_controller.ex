defmodule TasktrackerWeb.TodoController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Todos
  alias Tasktracker.Todos.Todo

  plug :authenticate_user

  def index(conn, _params) do
    # TODO: Only fetch todos for the authenticated user for this assign
    todos = Todos.list_todos()
    my_id = get_session(conn, :user_id)
    IO.puts " % % % % % % % % % % % % % %  % % % % "
    IO.puts my_id
    IO.puts " % % % % % % % % % % % % % %  % % % % "
    my_todos = Todos.list_todos_by_id(my_id)
    IO.puts inspect my_todos
    IO.puts " % % % % % % % % % % % % % %  % % % % "

    render(conn, "index.html", todos: todos, my_todos: my_todos)
  end

  def new(conn, _params) do
    changeset = Todos.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    user_id = get_session(conn, :user_id)
    todo_params = Map.put(todo_params, "user_id", user_id)

    case Todos.create_todo(todo_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: todo_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    render(conn, "show.html", todo: todo)
  end

  def edit(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    changeset = Todos.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todos.get_todo!(id)

    case Todos.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    {:ok, _todo} = Todos.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: todo_path(conn, :index))
  end
end
