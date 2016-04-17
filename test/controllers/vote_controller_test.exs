defmodule VotingService.VoteControllerTest do
  use VotingService.ConnCase

  alias VotingService.Vote
  @valid_attrs %{count: 42, model: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, vote_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    vote = Repo.insert! %Vote{}
    conn = get conn, vote_path(conn, :show, vote)
    assert json_response(conn, 200)["data"] == %{"id" => vote.id,
      "model" => vote.model,
      "count" => vote.count}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, vote_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, vote_path(conn, :create), vote: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Vote, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, vote_path(conn, :create), vote: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    vote = Repo.insert! %Vote{}
    conn = put conn, vote_path(conn, :update, vote), vote: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Vote, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    vote = Repo.insert! %Vote{}
    conn = put conn, vote_path(conn, :update, vote), vote: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    vote = Repo.insert! %Vote{}
    conn = delete conn, vote_path(conn, :delete, vote)
    assert response(conn, 204)
    refute Repo.get(Vote, vote.id)
  end
end
