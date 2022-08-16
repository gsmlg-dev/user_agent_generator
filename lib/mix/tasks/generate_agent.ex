defmodule Mix.Tasks.GenerateAgent do
  # Get user agent list from
  # http://www.user-agents.org/allagents.xml

  @moduledoc """
  The generate_agent mix task: `mix help generate_agent`

  Convert `priv/allagents.xml` to List and save to `lib/user_agent/all_agents.ex`

  The `priv/allagents.xml` is downloaded from *http://www.user-agents.org/allagents.xml*
  """
  use Mix.Task

  import SweetXml

  @shortdoc "generate lib/user_agent/all_agents.ex"
  def run(_) do
    xml =
      :code.priv_dir(:user_agent_generator)
      |> Path.join("allagents.xml")
      |> File.read!()

    list =
      xml
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
    defmodule UserAgent.AllAgents do
      # Auto generated, do not edit

      def list() do
        #{inspect(list, limit: :infinity, pretty: true)}
      end
    end
    """

    # IO.puts template

    generate_file = Path.join([__DIR__, "..", "..", "user_agent", "all_agents.ex"])
    # IO.puts generate_file

    File.write(generate_file, template)
  end
end
