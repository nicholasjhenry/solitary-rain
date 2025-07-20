defmodule Hello.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        total_price: "120.5"
      })

    {:ok, order} = Hello.Orders.create_order(scope, attrs)
    order
  end
end
