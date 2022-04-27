defmodule Lifetime.Medical do
  @moduledoc """
  The Medical context.
  """

  import Ecto.Query, warn: false
  alias Lifetime.Repo

  alias Lifetime.Medical.Transmission

  @doc """
  Returns the list of transmissions.

  ## Examples

      iex> list_transmissions()
      [%Transmission{}, ...]

  """
  def list_transmissions do
    Repo.all(Transmission)
  end

  @doc """
  Gets a single transmission.

  Raises `Ecto.NoResultsError` if the Transmission does not exist.

  ## Examples

      iex> get_transmission!(123)
      %Transmission{}

      iex> get_transmission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transmission!(id), do: Repo.get!(Transmission, id)

  @doc """
  Creates a transmission.

  ## Examples

      iex> create_transmission(%{field: value})
      {:ok, %Transmission{}}

      iex> create_transmission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transmission(attrs \\ %{}) do
    %Transmission{}
    |> Transmission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transmission.

  ## Examples

      iex> update_transmission(transmission, %{field: new_value})
      {:ok, %Transmission{}}

      iex> update_transmission(transmission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transmission(%Transmission{} = transmission, attrs) do
    transmission
    |> Transmission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transmission.

  ## Examples

      iex> delete_transmission(transmission)
      {:ok, %Transmission{}}

      iex> delete_transmission(transmission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transmission(%Transmission{} = transmission) do
    Repo.delete(transmission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transmission changes.

  ## Examples

      iex> change_transmission(transmission)
      %Ecto.Changeset{data: %Transmission{}}

  """
  def change_transmission(%Transmission{} = transmission, attrs \\ %{}) do
    Transmission.changeset(transmission, attrs)
  end

  alias Lifetime.Medical.Patient

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get_patient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patient!(id), do: Repo.get!(Patient, id)

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs \\ %{}) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples

      iex> change_patient(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change_patient(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end
end
