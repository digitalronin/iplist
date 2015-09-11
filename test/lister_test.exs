defmodule Lister do
  use ExUnit.Case

  import Iplist.Lister

  test "a single ip" do
    assert Iplist.Lister.list("1.2.3.4") == [ "1.2.3.4" ]
  end

  # 1.2.3.4..1.2.3.5
  # 1.2.3.253..1.2.4.2
  # 1.2.254.254..1.3.0.1
  # 1.254.254.254..2.0.0.1
end
