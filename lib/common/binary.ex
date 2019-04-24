defmodule BinaryOperations do
  def reverse(binary) when is_binary(binary), do: do_reverse(binary, <<>>)
  defp do_reverse(<<>>, acc), do: acc
  defp do_reverse(<<x::binary-size(1), bin::binary>>, acc), do: do_reverse(bin, x <> acc)
end
