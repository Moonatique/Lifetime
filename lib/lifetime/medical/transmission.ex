defmodule Lifetime.Medical.Transmission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifetime.Medical.Patient

  schema "transmissions" do
    field :data, {:array, :string}
    field :description, :string
    field :end_date, :date
    field :start_date, :date
    field :statue, Ecto.Enum, values: [:todo, :inprogress, :done, :reported, :canceled]
    field :type, Ecto.Enum, values: [:particularity, :treatment, :event, :question]
    belongs_to :patient, Patient

    timestamps()
  end

  @doc false
  def changeset(transmission, attrs) do
    transmission
    |> cast(attrs, [:type, :description, :statue, :start_date, :end_date, :data, :patient_id])
    |> validate_required([:type, :description, :statue, :start_date, :end_date, :data])
  end
end
