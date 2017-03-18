defmodule Otherpool.Userp do
  use Otherpool.Web, :model

  schema "userps" do
    field :password_hash, :string
    field :password, :string, virtual: true      
    belongs_to :person, Otherpool.Person, foreign_key: :person_id
    belongs_to :type, Otherpool.Type, foreign_key: :type_id

    timestamps()
  end
      
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password, :person_id,:type_id])
    |> hash_password
  end
    
    defp hash_password(changeset) do  
  if password = get_change(changeset, :password) do
    changeset
    |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  else
    changeset
  end
    end        
end
