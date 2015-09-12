defmodule Iplist.Lister do
  @doc """
  Treat each line from standard input as a string representation of an IP range,
  expand the range(s) and output each IP on a line.
  """
  def readlines do
    case IO.read(:stdio, :line) do
      :eof -> exit(:normal)
      line -> expand(String.strip line)
    end
    readlines
  end

  @doc """
  Expand a string representation of an IP range and output each IP on a line.
  """
  def expand(str) do
    Iplist.Ip.range(str) |> Enum.map &Iplist.Ip.to_string(&1) |> IO.puts
  end
end
