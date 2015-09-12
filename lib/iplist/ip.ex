defmodule Iplist.Ip do
  def increment({254, 254, 254, 254}), do: raise "No more IPs!"
  def increment({a, 254, 254, 254}),   do: {a + 1, 0, 0, 0}
  def increment({a, b, 254, 254}),     do: {a, b + 1, 0, 0}
  def increment({a, b, c, 254}),       do: {a, b, c + 1, 0}
  def increment({a, b, c, d}),         do: {a, b, c, d + 1}

  def range(str) when is_binary(str) do
    case String.split(str, "..") do
      [a, b] -> range(from_string(a), from_string(b))
      [a]    -> case String.split(a, "/") do
        [ip] -> range(from_string(ip), from_string(ip))
        [ip, netmask] -> range_from_cidr(ip, netmask)
      end
    end
  end
  def range(a, a) when is_tuple(a), do: [a]
  # TODO: Implement this as a stream
  def range(a, b) when is_tuple(a) and is_tuple(b) and b > a do
    List.flatten [a, range(increment(a), b)]
  end
  def range(a, b) when is_binary(a) and is_binary(b) do
    range(from_string(a), from_string(b))
  end

  def from_string(str) do
    list = String.split(str, ".") |> Enum.map &String.to_integer(&1)
    list_as_tuple list
  end

  def to_string({a, b, c, d}), do: Enum.join([a, b, c, d], ".")

  defp range_from_cidr(ip, netmask) do
    cidr = CIDR.parse "#{ip}/#{netmask}"
    List.flatten range_in_cidr(cidr, from_string(ip))
  end

  defp range_in_cidr(cidr, tuple) do
    next = increment tuple
    list = [tuple]
    if CIDR.match(cidr, next) do
      [list|range_in_cidr(cidr, next)]
    else
      list
    end
  end

  defp list_as_tuple([a, b, c, d]) do
    {a, b, c, d}
  end
end
