defmodule VotingService.VoteController do
  use VotingService.Web, :controller
  alias VotingService.Vote
  plug :scrub_params, "vote" when action in [:create, :update]

  def index(conn, _params) do
    {:ok, client} = Exredis.start_link

    models = client |> Exredis.query ["HGETALL", "models"]

    json conn, %{ value: models }
  end

  def create(conn, %{"vote" => vote_params}) do
    model = Map.get(vote_params, "model", "unknown")

    {:ok, client} = Exredis.start_link
    client |> Exredis.query ["HINCRBY", "models", model, 1]

    conn
    |> send_resp(201, "")
  end
end
