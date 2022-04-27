defmodule LifetimeWeb.TransmissionController do
  use LifetimeWeb, :controller

  alias Lifetime.Medical
  alias Lifetime.Medical.Transmission

  def index(conn, _params) do
    transmissions = Medical.list_transmissions()
    render(conn, "index.html", transmissions: transmissions)
  end

  def new(conn, _params) do
    changeset = Medical.change_transmission(%Transmission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transmission" => transmission_params}) do
    case Medical.create_transmission(transmission_params) do
      {:ok, transmission} ->
        conn
        |> put_flash(:info, "Transmission created successfully.")
        |> redirect(to: Routes.transmission_path(conn, :show, transmission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transmission = Medical.get_transmission!(id)
    render(conn, "show.html", transmission: transmission)
  end

  def edit(conn, %{"id" => id}) do
    transmission = Medical.get_transmission!(id)
    changeset = Medical.change_transmission(transmission)
    render(conn, "edit.html", transmission: transmission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transmission" => transmission_params}) do
    transmission = Medical.get_transmission!(id)

    case Medical.update_transmission(transmission, transmission_params) do
      {:ok, transmission} ->
        conn
        |> put_flash(:info, "Transmission updated successfully.")
        |> redirect(to: Routes.transmission_path(conn, :show, transmission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transmission: transmission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transmission = Medical.get_transmission!(id)
    {:ok, _transmission} = Medical.delete_transmission(transmission)

    conn
    |> put_flash(:info, "Transmission deleted successfully.")
    |> redirect(to: Routes.transmission_path(conn, :index))
  end
end
