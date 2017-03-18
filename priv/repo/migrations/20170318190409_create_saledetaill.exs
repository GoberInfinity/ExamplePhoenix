defmodule Otherpool.Repo.Migrations.CreateSaledetaill do
  use Ecto.Migration

  def change do
    create table(:saledetaills) do
      add :order_date, :date
      add :due_date, :date
      add :subtotal, :integer
      add :sale_type_id, references(:sale_types, on_delete: :nothing)
      add :userp_id, references(:userps, on_delete: :nothing)

      timestamps()
    end
    create index(:saledetaills, [:sale_type_id])
    create index(:saledetaills, [:userp_id])

  end
end
