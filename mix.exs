defmodule EfestoClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :efesto_client,
      version: "1.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:confex, "~> 3.4"},
      {:credo, "~> 0.9", only: :dev, runtime: false},
      {:dummy, "~> 1.1", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:tesla, "~> 1.2"}
    ]
  end

  defp description do
    "Client for Efesto in Elixir"
  end

  defp package do
    [
      name: :efesto_client,
      files: ~w(mix.exs lib .formatter.exs README.md LICENSE),
      maintainers: ["Jacopo Cascioli"],
      licenses: ["MPL 2.0"],
      links: %{"GitHub" => "https://github.com/Vesuvium/efesto_client"}
    ]
  end
end
