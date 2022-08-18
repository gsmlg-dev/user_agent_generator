defmodule UserAgent do
  @doc "Return a random user agent from most common user agents"
  def random() do
    len = UserAgent.Data.most_common() |> length
    r = Enum.random(0..(len - 1))
    UserAgent.Data.most_common() |> Enum.at(r)
  end

  @doc "Return a random user agent from all agents"
  def random_all() do
    len = UserAgent.Data.all_agents() |> length
    r = Enum.random(0..(len - 1))
    UserAgent.Data.all_agents() |> Enum.at(r) |> Map.get(:name)
  end
end
