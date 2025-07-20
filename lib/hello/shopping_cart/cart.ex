defmodule Hello.ShoppingCart.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do

    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart, attrs, user_scope) do
    cart
    |> cast(attrs, [])
    |> validate_required([])
    |> put_change(:user_id, user_scope.user.id)
  end
end
