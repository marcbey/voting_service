defmodule VotingService.VoteView do
  use VotingService.Web, :view
  attributes [:model, :count]

  def render("index.json", %{votes: votes}) do
    %{data: render_many(votes, VotingService.VoteView, "vote.json")}
  end

  def render("show.json", %{vote: vote}) do
    %{data: render_one(vote, VotingService.VoteView, "vote.json")}
  end

  def render("vote.json", %{vote: vote}) do
    %{id: vote.id,
      model: vote.model,
      count: vote.count}
  end
end
