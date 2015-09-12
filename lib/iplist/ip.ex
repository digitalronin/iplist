defmodule Iplist.Ip do
  @doc """
  Given a tuple representing an IP number, return the next tuple.

  ## Example

      iex> Iplist.Ip.increment {1, 2, 3, 4}
      {1, 2, 3, 5}

      iex> Iplist.Ip.increment {1, 2, 255, 255}
      {1, 3, 0, 0}

  """
  def increment({255, 255, 255, 255}), do: raise "No more IPs!"
  def increment({a, 255, 255, 255}),   do: {a + 1, 0, 0, 0}
  def increment({a, b, 255, 255}),     do: {a, b + 1, 0, 0}
  def increment({a, b, c, 255}),       do: {a, b, c + 1, 0}
  def increment({a, b, c, d}),         do: {a, b, c, d + 1}

  @doc """
  Take string, in various formats, representing an IP range
  return a list of all IPs in the range, as tuples.

  ## Example

      iex> Iplist.Ip.range "1.2.3.4"
      [{1, 2, 3, 4}]

      iex> Iplist.Ip.range "1.2.3.4..1.2.3.5"
      [{1, 2, 3, 4}, {1, 2, 3, 5}]

      iex> Iplist.Ip.range("1.2.3.4/31")
      [{1, 2, 3, 4}, {1, 2, 3, 5}]

  """
  def range(str) when is_binary(str) do
    case String.split(str, "..") do
      [a, b] -> range(from_string(a), from_string(b))
      [a]    -> case String.split(a, "/") do
        [ip] -> range(from_string(ip), from_string(ip))
        [ip, netmask] -> range_from_cidr(ip, netmask)
      end
    end
  end

  @doc """
  Given the start and end of an IP range, as two strings or two tuples,
  return a list of all IPs in the range, as tuples.

  ## Example

      iex> Iplist.Ip.range("1.2.3.4", "1.2.3.5")
      [{1, 2, 3, 4}, {1, 2, 3, 5}]

      iex> Iplist.Ip.range({1, 2, 3, 4}, {1, 2, 3, 5})
      [{1, 2, 3, 4}, {1, 2, 3, 5}]

  """
  def range(a, a) when is_tuple(a), do: [a]
  # TODO: Implement this as a stream
  def range(a, b) when is_tuple(a) and is_tuple(b) and b > a do
    [a|range(increment(a), b)]
  end
  def range(a, b) when is_binary(a) and is_binary(b) do
    range(from_string(a), from_string(b))
  end

  @doc """
  Given a string representing an IP number, return the corresponding tuple.

  ## Example

      iex> Iplist.Ip.from_string "1.2.3.4"
      {1, 2, 3, 4}

  """
  def from_string(str) do
    list = String.split(str, ".") |> Enum.map &String.to_integer(&1)
    list_as_tuple list
  end

  @doc """
  Convert an IP number tuple to a string.

  ## Example

      iex> Iplist.Ip.to_string {1, 2, 3, 4}
      "1.2.3.4"

  """
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
