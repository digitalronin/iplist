defmodule Iplist.Lister do
  def readlines do
    case IO.read(:stdio, :line) do
      :eof -> exit(:normal)
      line -> expand(String.strip line)
    end
    readlines
  end

  defp expand(str) do
    Iplist.Ip.range(str) |> Enum.map &Iplist.Ip.to_string(&1) |> IO.puts
  end
end
