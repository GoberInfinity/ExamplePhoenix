defmodule Otherpool.Repo.Migrations.CreateDeal do
  use Ecto.Migration

  def change do
    create table(:dealers) do
      add :stock, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:dealers, [:user_id])

  end
end
