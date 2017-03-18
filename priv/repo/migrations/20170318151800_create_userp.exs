defmodule Otherpool.Repo.Migrations.CreateUserp do
  use Ecto.Migration

  def change do
    create table(:userps) do
      add :password_hash, :string
      add :person_id, references(:persons, on_delete: :nothing)
      add :type_id, references(:user_types, on_delete: :nothing)

      timestamps()
    end
    create index(:userps, [:person_id])
    create index(:userps, [:type_id])

  end
end
