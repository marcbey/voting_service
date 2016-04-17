defmodule VotingService.Repo.Migrations.CreateVote do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :model, :string
      add :count, :integer

      timestamps
    end

  end
end
