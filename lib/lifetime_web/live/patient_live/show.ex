defmodule LifetimeWeb.PatientLive.Show do
  use LifetimeWeb, :live_surface

  alias Lifetime.Medical

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Medical.subscribe()

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:patient, Medical.get_patient!(id))}
  end

  defp page_title(:show), do: "Show Patient"
  defp page_title(:edit), do: "Edit Patient"

  @impl true
  def handle_info({:transmission_created, transmission}, socket) do
    {:noreply, 
      update(socket, :patient, 
        fn patient -> %{patient | transmissions: [transmission | patient.transmissions]} end)}
  end
end