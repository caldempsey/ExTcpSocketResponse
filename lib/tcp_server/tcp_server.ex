defmodule TcpServer do
  alias TcpServer.WorkerStrategy
  require Logger

  @doc """
  The entry point from which connections are made. Takes a port as input and generates a TCP socket adapter (erl)
  """
  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(
        port,
        [:binary, packet: :line, active: false, reuseaddr: true]
      )

    Logger.info("Accepting TCP connections on port #{port}")

    connect(socket)
  end

  defp connect(socket) do
    socket |> WorkerStrategy.loop_acceptor()
  end
end
