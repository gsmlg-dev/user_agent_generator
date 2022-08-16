defmodule Mix.Tasks.GenerateAgent do
  # Get user agent list from
  # http://www.user-agents.org/allagents.xml

  @moduledoc """
  The generate_agent mix task: `mix help generate_agent`

  Convert 

  - `priv/allagents.xml`
  - `priv/mostcommonuseragents.txt`

  Into Elixir and save to `lib/user_agent/data.ex`

  The `priv/allagents.xml` is downloaded from *http://www.user-agents.org/allagents.xml*

  The `priv/mostcommonuseragents.txt` is get from *https://techblog.willshouse.com/2012/01/03/most-common-user-agents/*
  """
  use Mix.Task

  import SweetXml

  @shortdoc "generate lib/user_agent/all_agents.ex"
  def run(_) do
    most_common =
      :code.priv_dir(:user_agent_generator)
      |> Path.join("mostcommonuseragents.txt")
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.trim/1)

    # IO.inspect most_common

    all_agents =
      :code.priv_dir(:user_agent_generator)
      |> Path.join("allagents.xml")
      |> File.read!()
      |> xpath(
        ~x"//user-agents/user-agent"l,
        id: ~x"./ID/text()"s,
        name: ~x"./String/text()"s,
        description: ~x"./Description/text()"s,
        type: ~x"./Type/text()"s,
        comment: ~x"./Comment/text()"s,
        link1: ~x"./Link1/text()"s,
        link2: ~x"./Link2/text()"s
      )

    template = """
    defmodule UserAgent.Data do
      # Auto generated, do not edit

      def all_agents() do
        #{inspect(all_agents, limit: :infinity, pretty: true)}
      end

      def most_common() do
        #{inspect(most_common, limit: :infinity, pretty: true)}
      end
    end
    """

    # IO.puts template

    generate_file = Path.join([__DIR__, "..", "..", "user_agent", "data.ex"])
    # IO.puts generate_file

    File.write(generate_file, template)
  end
end
