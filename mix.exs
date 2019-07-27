defmodule Mimicron.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :mimicron,
      version: @version,
      elixir: "~> 1.3",
      description: "callstack tracer",
      package: package(),
      deps: deps(),
      name: "Mimicron",
      source_url: "https://github.com/jcoder39/mimicron",
      docs: [
        main: "Mimicron"
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Viacheslav Borisenko"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/jcoder39/mimicron",
        "Docs" => "https://hexdocs.pm/mimicron/"
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
