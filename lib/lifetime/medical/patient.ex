defmodule Lifetime.Medical.Patient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifetime.Accounts.User
  alias Lifetime.Medical.Transmission

  schema "patients" do
    field :birthdate, :date
    field :blood_group, Ecto.Enum, values: [:"A+", :"A-", :"B+", :"B-", :"O+", :"O-", :"AB+", :"AB-"]
    field :firstname, :string
    field :lastname, :string
    field :numSS, :string
    belongs_to :user, User
    has_many :transmissions, Transmission

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:numSS, :lastname, :firstname, :birthdate, :blood_group])
    |> validate_required([:numSS, :lastname, :firstname, :birthdate, :blood_group])
  end
end
