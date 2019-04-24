defmodule TcpServer.ConnectionStrategy do
  @doc """
  Connection strategy where a connection is made by starting a new Task to handle a socket on a given port. 
  """
  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, pid} =
      Task.Supervisor.start_child(TcpServer.TaskSupervisor, fn ->
        TcpServer.Response.determine_response_from_binary(client)
      end)

    :ok = :gen_tcp.controlling_process(client, pid)

    # The tail call is only reached if the process crashes, from which we should handle an error at the start of the function call.
    loop_acceptor(socket)
  end
end
