defmodule UserAgent.Generator.Mixfile do
  use Mix.Project

  # Also change package.json version
  @source_url "https://github.com/gsmlg-dev/user_agent_generator.git"
  @version "0.0.0"

  def project do
    [
      app: :user_agent_generator,
      version: @version,
      elixir: "~> 1.7",
      config_path: "config/config.exs",
      deps: deps(),
      name: "UserAgent.Generator",
      description: "Generate random user-agent",
      package: package(),
      aliases: aliases(),
      docs: [
        extras: ["CHANGELOG.md"],
        source_url: @source_url,
        source_ref: "v#{@version}",
        main: "UserAgent.Generator",
        skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:eex, :logger],
      env: [csrf_token_reader: {Plug.CSRFProtection, :get_csrf_token_for, []}]
    ]
  end

  defp deps do
    [
      {:sweet_xml, "~> 0.7.1", runtime: false},
      {:ex_doc, ">= 0.0.0", only: :prod, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Jonathan Gao"],
      licenses: ["MIT"],
      files: ~w(lib priv CHANGELOG.md LICENSE mix.exs package.json README.md),
      links: %{
        Changelog: "https://hexdocs.pm/user_agent_generator/changelog.html",
        GitHub: @source_url
      }
    ]
  end

  defp aliases do
    []
  end
end
