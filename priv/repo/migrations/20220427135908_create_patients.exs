defmodule Lifetime.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :numSS, :string
      add :lastname, :string
      add :firstname, :string
      add :birthdate, :date
      add :blood_group, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:patients, [:user_id])
  end
end
