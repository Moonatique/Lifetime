defmodule Lifetime.Repo.Migrations.CreateTransmissions do
  use Ecto.Migration

  def change do
    create table(:transmissions) do
      add :type, :string
      add :description, :string
      add :statue, :string
      add :start_date, :date
      add :end_date, :date
      add :data, {:array, :string}
      add :patient_id, references(:patients, on_delete: :nothing)

      timestamps()
    end

    create index(:transmissions, [:patient_id])
  end
end
