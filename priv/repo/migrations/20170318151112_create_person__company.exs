defmodule Otherpool.Repo.Migrations.CreatePerson_Company do
  use Ecto.Migration

  def change do
    create table(:person_companies) do
      add :name_company, :string
      add :person_id, references(:persons, on_delete: :nothing)

      timestamps()
    end
    create index(:person_companies, [:person_id])

  end
end
