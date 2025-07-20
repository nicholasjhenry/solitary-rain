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

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{
        price_when_carted: "120.5",
        quantity: 42
      })
      |> Hello.ShoppingCart.create_cart_item()

    cart_item
  end
end
