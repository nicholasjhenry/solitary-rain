defmodule Hello.ShoppingCartFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.ShoppingCart` context.
  """

  @doc """
  Generate a cart.
  """
  def cart_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{

      })

    {:ok, cart} = Hello.ShoppingCart.create_cart(scope, attrs)
    cart
  end
end
