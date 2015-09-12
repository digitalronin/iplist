defmodule Iplist.Ip do
  def increment({254, 254, 254, 254}), do: raise "No more IPs!"
  def increment({a, 254, 254, 254}),   do: {a + 1, 0, 0, 0}
  def increment({a, b, 254, 254}),     do: {a, b + 1, 0, 0}
  def increment({a, b, c, 254}),       do: {a, b, c + 1, 0}
  def increment({a, b, c, d}),         do: {a, b, c, d + 1}

  def range(str) when is_binary(str) do
    case String.split(str, "..") do
      [a, b] -> range(from_string(a), from_string(b))
      [a]    -> range(from_string(a), from_string(a))
    end
  end
  def range(a, a) when is_tuple(a), do: [a]
  # TODO: Implement this as a stream
  def range(a, b) when is_tuple(a) and is_tuple(b) do
    List.flatten [a, range(increment(a), b)]
  end

  def from_string(str) do
    list = String.split(str, ".") |> Enum.map &String.to_integer(&1)
    list_as_tuple list
  end

  defp list_as_tuple([a, b, c, d]) do
    {a, b, c, d}
  end
end
