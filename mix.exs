defmodule Recaptcha.Mixfile do
  use Mix.Project

  def project do
    [
      app: :recaptcha,
      version: "2.3.0",
      elixir: "~> 1.4",
      description: description(),
      deps: deps(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,

      # Test coverage:
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Dialyzer:
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [:poison]
      ]
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :eex]]
  end

  defp description do
    """
    A simple reCaptcha package for Elixir applications, provides verification
    and templates for rendering forms with the reCaptcha widget
    """
  end

  defp deps do
    [
      {:httpoison, ">= 0.12.0"},
      {:poison, "~> 4.0 or ~> 3.1.0 or ~> 2.2.0 or ~> 1.5.2"},
      {:credo, "~> 0.9.3", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev]},
      {:excoveralls, "~> 0.7.1", only: :test}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Samuel Seay", "Nikita Sobolev", "Michael JustMikey"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/samueljseay/recaptcha"}
    ]
  end
end
