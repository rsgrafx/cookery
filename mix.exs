defmodule Cookery.MixProject do
  use Mix.Project

  def project do
    [
      app: :cookery,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :plug],
      mod: {Cookery.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.5.0"},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:absinthe_plug, "~> 1.4.2"},
      {:bypass, "~> 0.8.0", only: :test}
    ]
  end
end
