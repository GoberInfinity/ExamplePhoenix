defmodule Otherpool.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fullname, :string
      add :email, :string

      timestamps()
    end

  end
end
