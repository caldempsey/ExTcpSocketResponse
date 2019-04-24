defmodule TcpServer.Response do
  @doc """
  Res[]
  """

  def determine_response_from_binary(socket) do
    case socket |> read_line() do
      <<"ping">> -> pong(socket)
      _ -> reverse_binary(socket)
    end
  end

  def pong(socket) do
    write_line("pong", socket)
    determine_response_from_binary(socket)
  end

  def reverse_binary(socket) do
    socket
    |> read_line()
    |> BinaryOperations.reverse()
    |> write_line(socket)

    determine_response_from_binary(socket)
  end

  defp read_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end
