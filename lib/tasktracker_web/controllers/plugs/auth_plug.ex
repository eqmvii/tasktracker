defmodule TasktrackerWeb.AuthPlug do
    import Plug.Conn
    import Phoenix.Controller
    
    alias TasktrackerWeb.Router.Helpers

    # authentication plug
    def authenticate_user(conn, _) do
        if get_session(conn, :logged_in) do
            conn
        else
            conn
            |> put_flash(:error, "Error: you are not logged in")
            |> redirect(to: Helpers.page_path(conn, :index))
            |> halt()
        end
    end

end