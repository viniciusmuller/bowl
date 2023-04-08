defmodule Bowl.Cache do
  use Nebulex.Cache,
    otp_app: :bowl,
    adapter: Nebulex.Adapters.Replicated
end
