defmodule Otherpool.Repo.Migrations.CreatePerson_Phone do
  use Ecto.Migration

  def change do
    create table(:person_phones) do
      add :phone_number, :integer
      add :person_id, references(:persons, on_delete: :nothing)

      timestamps()
    end
    create index(:person_phones, [:person_id])

  end
end
