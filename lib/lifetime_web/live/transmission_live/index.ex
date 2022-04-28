defmodule LifetimeWeb.TransmissionLive.Index do
  use LifetimeWeb, :live_view

  alias Lifetime.Medical
  alias Lifetime.Medical.Transmission

  @impl true
  def mount(params, _session, socket) do
    socket = assign(socket, :patient, Medical.get_patient!(params["id"]))
    {:ok, assign(socket, :transmissions, list_transmissions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Transmission")
    |> assign(:transmission, Medical.get_transmission!(id))
  end

  defp apply_action(socket, :new, %{"id" => id}) do
    transmission = %Transmission{patient_id: id}

    socket
    |> assign(:page_title, "New Transmission")
    |> assign(:patient, Medical.get_patient!(id))
    |> assign(:transmission, transmission)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Transmissions")
    |> assign(:transmission, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    transmission = Medical.get_transmission!(id)
    {:ok, _} = Medical.delete_transmission(transmission)

    {:noreply, assign(socket, :transmissions, list_transmissions())}
  end

  defp list_transmissions do
    Medical.list_transmissions()
  end
end
