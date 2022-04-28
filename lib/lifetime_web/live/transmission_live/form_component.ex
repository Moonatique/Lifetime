defmodule LifetimeWeb.TransmissionLive.FormComponent do
  use LifetimeWeb, :live_component

  alias Lifetime.Medical

  @impl true
  def update(%{transmission: transmission} = assigns, socket) do
    changeset = Medical.change_transmission(transmission)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:patient, Medical.get_patient!(transmission.patient_id))}
  end

  @impl true
  def handle_event("validate", %{"transmission" => transmission_params}, socket) do
    changeset =
      socket.assigns.transmission
      |> Medical.change_transmission(transmission_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"transmission" => transmission_params}, socket) do
    save_transmission(socket, socket.assigns.action, transmission_params)
  end

  defp save_transmission(socket, :edit, transmission_params) do
    case Medical.update_transmission(socket.assigns.transmission, transmission_params) do
      {:ok, _transmission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transmission updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_transmission(socket, :new, transmission_params) do
    transmission_params = Map.put(transmission_params, "patient_id", socket.assigns.patient.id)
    case Medical.create_transmission(transmission_params) do
      {:ok, _transmission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transmission created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
