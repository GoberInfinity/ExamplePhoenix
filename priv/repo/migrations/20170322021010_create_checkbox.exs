defmodule Otherpool.Repo.Migrations.CreateCheckbox do
  use Ecto.Migration

  def change do
    create table(:checkboxes) do
      add :description, :string
      add :checked, :boolean, default: false, null: false
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end
    create index(:checkboxes, [:list_id])

  end
end
