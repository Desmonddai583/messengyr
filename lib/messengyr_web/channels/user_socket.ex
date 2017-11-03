defmodule MessengyrWeb.UserSocket do
  use Phoenix.Socket

  import Messengyr.Accounts.GuardianSerializer, only: [from_token: 1]

  channel "room:*", MessengyrWeb.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"guardianToken" => jwt}, socket) do

    # Decode the jtw and get the user associated with it:
    with {:ok, claims} <- Guardian.decode_and_verify(jwt),
         {:ok, user} <- from_token(claims["sub"])
    do
      # Assign the user to the socket!
      {:ok, assign(socket, :current_user, user)}
    else
      _ -> :error
    end
  end

  def connect(_params, _socket) do
    :error
  end

  def id(_socket), do: nil
end
