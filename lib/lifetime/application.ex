defmodule Lifetime.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Lifetime.Repo,
      # Start the Telemetry supervisor
      LifetimeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lifetime.PubSub},
      # Start the Endpoint (http/https)
      LifetimeWeb.Endpoint
      # Start a worker by calling: Lifetime.Worker.start_link(arg)
      # {Lifetime.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lifetime.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LifetimeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
