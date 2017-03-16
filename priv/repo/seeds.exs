# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Otherpool.Repo.insert!(%Otherpool.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Otherpool.Repo
alias Otherpool.Dummy

[
    %Dummy{
        name: "Pedro",
        age: 21
        },
    %Dummy{
        name: "Armando",
        age: 19
        }
    
    ] |> Enum.each(&Repo.insert!(&1))



#curl -H "Content-Type: application/json" -X POST -d '{"Dummy": {"age": 23, "name": "Jeff Baird"}}'   http://localhost:4000/api/dummies
