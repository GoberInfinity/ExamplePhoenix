defmodule Otherpool.Repo.Migrations.CreateUser_Type do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :name_type, :string

      timestamps()
    end

  end
end
