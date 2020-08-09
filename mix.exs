defmodule UkCovid19Sdk.MixProject do
  use Mix.Project

  def project do
    [
      app: :uk_covid19_sdk,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "UK Covid19 SDK",
      source_url: "https://github.com/publichealthengland/coronavirus-dashboard-api-elixir-sdk",
      homepage_url: "https://coronavirus.data.gov.uk/",
      docs: [
        # The main page in the docs
        main: "UK Covid19 SDK",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:poison, "~> 4.0"},
      {:timex, "~> 3.6"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
