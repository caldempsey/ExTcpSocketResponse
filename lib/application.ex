defmodule PutASocketInIt do
  use Application

  def start(_type, _args) do
    port =
      String.to_integer(System.get_env("PORT") || raise("missing $PORT environment variable"))

    children = [
      {Task.Supervisor, name: TcpServer.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> TcpServer.accept(port) end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: TcpServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
