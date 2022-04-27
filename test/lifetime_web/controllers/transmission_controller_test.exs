defmodule LifetimeWeb.TransmissionControllerTest do
  use LifetimeWeb.ConnCase

  import Lifetime.MedicalFixtures

  @create_attrs %{data: [], description: "some description", end_date: ~D[2022-04-26], start_date: ~D[2022-04-26], statue: :todo, type: :particularity}
  @update_attrs %{data: [], description: "some updated description", end_date: ~D[2022-04-27], start_date: ~D[2022-04-27], statue: :inprogress, type: :treatment}
  @invalid_attrs %{data: nil, description: nil, end_date: nil, start_date: nil, statue: nil, type: nil}

  describe "index" do
    test "lists all transmissions", %{conn: conn} do
      conn = get(conn, Routes.transmission_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Transmissions"
    end
  end

  describe "new transmission" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.transmission_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transmission"
    end
  end

  describe "create transmission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transmission_path(conn, :create), transmission: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.transmission_path(conn, :show, id)

      conn = get(conn, Routes.transmission_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transmission"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transmission_path(conn, :create), transmission: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transmission"
    end
  end

  describe "edit transmission" do
    setup [:create_transmission]

    test "renders form for editing chosen transmission", %{conn: conn, transmission: transmission} do
      conn = get(conn, Routes.transmission_path(conn, :edit, transmission))
      assert html_response(conn, 200) =~ "Edit Transmission"
    end
  end

  describe "update transmission" do
    setup [:create_transmission]

    test "redirects when data is valid", %{conn: conn, transmission: transmission} do
      conn = put(conn, Routes.transmission_path(conn, :update, transmission), transmission: @update_attrs)
      assert redirected_to(conn) == Routes.transmission_path(conn, :show, transmission)

      conn = get(conn, Routes.transmission_path(conn, :show, transmission))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, transmission: transmission} do
      conn = put(conn, Routes.transmission_path(conn, :update, transmission), transmission: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transmission"
    end
  end

  describe "delete transmission" do
    setup [:create_transmission]

    test "deletes chosen transmission", %{conn: conn, transmission: transmission} do
      conn = delete(conn, Routes.transmission_path(conn, :delete, transmission))
      assert redirected_to(conn) == Routes.transmission_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.transmission_path(conn, :show, transmission))
      end
    end
  end

  defp create_transmission(_) do
    transmission = transmission_fixture()
    %{transmission: transmission}
  end
end
