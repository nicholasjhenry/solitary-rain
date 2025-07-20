defmodule Hello.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :total_price, :decimal
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs, user_scope) do
    order
    |> cast(attrs, [:total_price])
    |> validate_required([:total_price])
    |> put_change(:user_id, user_scope.user.id)
  end
end
