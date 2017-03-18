defmodule Otherpool.Repo.Migrations.CreateSale_Type do
  use Ecto.Migration

  def change do
    create table(:sale_types) do
      add :name_sale, :string

      timestamps()
    end

  end
end
