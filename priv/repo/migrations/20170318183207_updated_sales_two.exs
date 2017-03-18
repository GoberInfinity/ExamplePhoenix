defmodule Otherpool.Repo.Migrations.UpdatedSalesTwo do
  use Ecto.Migration

  def change do
      alter table(:sales) do
       add :userp_id, references(:userps, on_delete: :nothing)
   end
   end
end
