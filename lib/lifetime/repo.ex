defmodule Lifetime.Repo do
  use Ecto.Repo,
    otp_app: :lifetime,
    adapter: Ecto.Adapters.Postgres
end
