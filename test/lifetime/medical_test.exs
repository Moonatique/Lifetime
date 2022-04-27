defmodule Lifetime.MedicalTest do
  use Lifetime.DataCase

  alias Lifetime.Medical

  describe "transmissions" do
    alias Lifetime.Medical.Transmission

    import Lifetime.MedicalFixtures

    @invalid_attrs %{data: nil, description: nil, end_date: nil, start_date: nil, statue: nil, type: nil}

    test "list_transmissions/0 returns all transmissions" do
      transmission = transmission_fixture()
      assert Medical.list_transmissions() == [transmission]
    end

    test "get_transmission!/1 returns the transmission with given id" do
      transmission = transmission_fixture()
      assert Medical.get_transmission!(transmission.id) == transmission
    end

    test "create_transmission/1 with valid data creates a transmission" do
      valid_attrs = %{data: [], description: "some description", end_date: ~D[2022-04-26], start_date: ~D[2022-04-26], statue: :todo, type: :particularity}

      assert {:ok, %Transmission{} = transmission} = Medical.create_transmission(valid_attrs)
      assert transmission.data == []
      assert transmission.description == "some description"
      assert transmission.end_date == ~D[2022-04-26]
      assert transmission.start_date == ~D[2022-04-26]
      assert transmission.statue == :todo
      assert transmission.type == :particularity
    end

    test "create_transmission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Medical.create_transmission(@invalid_attrs)
    end

    test "update_transmission/2 with valid data updates the transmission" do
      transmission = transmission_fixture()
      update_attrs = %{data: [], description: "some updated description", end_date: ~D[2022-04-27], start_date: ~D[2022-04-27], statue: :inprogress, type: :treatment}

      assert {:ok, %Transmission{} = transmission} = Medical.update_transmission(transmission, update_attrs)
      assert transmission.data == []
      assert transmission.description == "some updated description"
      assert transmission.end_date == ~D[2022-04-27]
      assert transmission.start_date == ~D[2022-04-27]
      assert transmission.statue == :inprogress
      assert transmission.type == :treatment
    end

    test "update_transmission/2 with invalid data returns error changeset" do
      transmission = transmission_fixture()
      assert {:error, %Ecto.Changeset{}} = Medical.update_transmission(transmission, @invalid_attrs)
      assert transmission == Medical.get_transmission!(transmission.id)
    end

    test "delete_transmission/1 deletes the transmission" do
      transmission = transmission_fixture()
      assert {:ok, %Transmission{}} = Medical.delete_transmission(transmission)
      assert_raise Ecto.NoResultsError, fn -> Medical.get_transmission!(transmission.id) end
    end

    test "change_transmission/1 returns a transmission changeset" do
      transmission = transmission_fixture()
      assert %Ecto.Changeset{} = Medical.change_transmission(transmission)
    end
  end

  describe "patients" do
    alias Lifetime.Medical.Patient

    import Lifetime.MedicalFixtures

    @invalid_attrs %{birthdate: nil, blood_group: nil, firstname: nil, lastname: nil, numSS: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Medical.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Medical.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{birthdate: ~D[2022-04-26], blood_group: :"A+", firstname: "some firstname", lastname: "some lastname", numSS: "some numSS"}

      assert {:ok, %Patient{} = patient} = Medical.create_patient(valid_attrs)
      assert patient.birthdate == ~D[2022-04-26]
      assert patient.blood_group == :"A+"
      assert patient.firstname == "some firstname"
      assert patient.lastname == "some lastname"
      assert patient.numSS == "some numSS"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Medical.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{birthdate: ~D[2022-04-27], blood_group: :"A-", firstname: "some updated firstname", lastname: "some updated lastname", numSS: "some updated numSS"}

      assert {:ok, %Patient{} = patient} = Medical.update_patient(patient, update_attrs)
      assert patient.birthdate == ~D[2022-04-27]
      assert patient.blood_group == :"A-"
      assert patient.firstname == "some updated firstname"
      assert patient.lastname == "some updated lastname"
      assert patient.numSS == "some updated numSS"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Medical.update_patient(patient, @invalid_attrs)
      assert patient == Medical.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Medical.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Medical.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Medical.change_patient(patient)
    end
  end
end
