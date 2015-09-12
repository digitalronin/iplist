defmodule Ip do
  use ExUnit.Case

  test "increment" do
    assert {1, 2, 3, 5} == Iplist.Ip.increment({1, 2, 3, 4})
    assert {1, 2, 4, 0} == Iplist.Ip.increment({1, 2, 3, 254})
    assert {1, 3, 0, 0} == Iplist.Ip.increment({1, 2, 254, 254})
    assert {2, 0, 0, 0} == Iplist.Ip.increment({1, 254, 254, 254})
    assert_raise RuntimeError, "No more IPs!", fn -> Iplist.Ip.increment({254, 254, 254, 254}) end
  end

  test "range" do
    assert [{1,2,3,4}]                       == Iplist.Ip.range({1,2,3,4}, {1,2,3,4})
    assert [{1,2,3,4}, {1,2,3,5}]            == Iplist.Ip.range({1,2,3,4}, {1,2,3,5})
    assert [{1,2,3,4}, {1,2,3,5}, {1,2,3,6}] == Iplist.Ip.range({1,2,3,4}, {1,2,3,6})
  end

  test "from string" do
    assert {1,2,3,4} == Iplist.Ip.from_string("1.2.3.4")
  end

  test "range from string" do
    assert [{1,2,3,4}]            == Iplist.Ip.range("1.2.3.4")
    assert [{1,2,3,4}, {1,2,3,5}] == Iplist.Ip.range("1.2.3.4..1.2.3.5")

    # CIDR
    assert [{1,2,3,4}]            == Iplist.Ip.range("1.2.3.4/32")
    assert [{1,2,3,4}, {1,2,3,5}] == Iplist.Ip.range("1.2.3.4/31")
    assert Iplist.Ip.range({1,2,3,0}, {1,2,3,254}) == Iplist.Ip.range("1.2.3.0/24")
  end

  test "range from strings" do
    assert [{1,2,3,4}, {1,2,3,5}] == Iplist.Ip.range("1.2.3.4", "1.2.3.5")
  end

  test "as string" do
    assert "1.2.3.4" == Iplist.Ip.to_string({1, 2, 3, 4})
  end
end
