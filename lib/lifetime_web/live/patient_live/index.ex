defmodule LifetimeWeb.PatientLive.Index do
  use LifetimeWeb, :live_view

  alias Lifetime.Medical
  alias Lifetime.Medical.Patient

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :patients, list_patients())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patient")
    |> assign(:patient, Medical.get_patient!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patient")
    |> assign(:patient, %Patient{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patients")
    |> assign(:patient, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patient = Medical.get_patient!(id)
    {:ok, _} = Medical.delete_patient(patient)

    {:noreply, assign(socket, :patients, list_patients())}
  end

  defp list_patients do
    Medical.list_patients()
  end
end
