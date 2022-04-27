defmodule Lifetime.MedicalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lifetime.Medical` context.
  """

  @doc """
  Generate a transmission.
  """
  def transmission_fixture(attrs \\ %{}) do
    {:ok, transmission} =
      attrs
      |> Enum.into(%{
        data: [],
        description: "some description",
        end_date: ~D[2022-04-26],
        start_date: ~D[2022-04-26],
        statue: :todo,
        type: :particularity
      })
      |> Lifetime.Medical.create_transmission()

    transmission
  end

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2022-04-26],
        blood_group: :"A+",
        firstname: "some firstname",
        lastname: "some lastname",
        numSS: "some numSS"
      })
      |> Lifetime.Medical.create_patient()

    patient
  end
end
