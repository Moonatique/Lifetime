defmodule LifetimeWeb.TransmissionLive.Show do
  use LifetimeWeb, :live_view

  alias Lifetime.Medical

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:transmission, Medical.get_transmission!(id))}
  end

  defp page_title(:show), do: "Show Transmission"
  defp page_title(:edit), do: "Edit Transmission"
end
