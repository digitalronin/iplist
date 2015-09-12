defmodule Iplist.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app:              :iplist,
      version:          @version,
      elixir:           "~> 1.0",
      name:             "Iplist",
      source_url:       "https://github.com/digitalronin/iplist",
      description:      "Library and CLI tool to expand IPv4 ranges to lists of IP numbers",
      build_embedded:   Mix.env == :prod,
      start_permanent:  Mix.env == :prod,
      escript:          escript_config,
      deps:             deps,
      package:          package
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      { :cidr,    ">= 0.2.0"                   },
      { :earmark, ">= 0.0.0"                   },
      { :ex_doc,  github: "elixir-lang/ex_doc" },
    ]
  end

  defp escript_config do
    [ main_module: Iplist.CLI ]
  end

  defp package do
    [
      contributors:  ["David Salgado"],
      licenses:      ["Apache 2.0"],
      links:         %{ "GitHub" => "https://github.com/digitalronin/iplist" }
    ]
  end
end
