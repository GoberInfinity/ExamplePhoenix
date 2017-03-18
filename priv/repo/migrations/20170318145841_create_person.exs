defmodule Otherpool.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :email, :string
      add :age, :integer
      add :birthday, :date

      timestamps()
    end

  end
end
