defmodule Otherpool.Repo.Migrations.UpdatedSales do
  use Ecto.Migration

  def change do
   alter table(:sales) do
       add :person_id, references(:userps, on_delete: :nothing)
   end
   end
end
