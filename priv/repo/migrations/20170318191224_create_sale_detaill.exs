defmodule Otherpool.Repo.Migrations.CreateSaleDetaill do
  use Ecto.Migration

  def change do
    create table(:sale_detaills) do
      add :order_date, :date
      add :due_date, :date
      add :subtotal, :integer
      add :sale_type_id, references(:sale_types, on_delete: :nothing)
      add :userp_id, references(:userps, on_delete: :nothing)

      timestamps()
    end
    create index(:sale_detaills, [:sale_type_id])
    create index(:sale_detaills, [:userp_id])

  end
end
