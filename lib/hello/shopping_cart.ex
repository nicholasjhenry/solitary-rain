defmodule Hello.ShoppingCart do
  @moduledoc """
  The ShoppingCart context.
  """

  import Ecto.Query, warn: false
  alias Hello.Repo

  alias Hello.ShoppingCart.Cart
  alias Hello.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any cart changes.

  The broadcasted messages match the pattern:

    * {:created, %Cart{}}
    * {:updated, %Cart{}}
    * {:deleted, %Cart{}}

  """
  def subscribe_carts(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Hello.PubSub, "user:#{key}:carts")
  end

  defp broadcast(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Hello.PubSub, "user:#{key}:carts", message)
  end

  @doc """
  Returns the list of carts.

  ## Examples

      iex> list_carts(scope)
      [%Cart{}, ...]

  """
  def list_carts(%Scope{} = scope) do
    Repo.all_by(Cart, user_id: scope.user.id)
  end

  @doc """
  Gets a single cart.

  Raises `Ecto.NoResultsError` if the Cart does not exist.

  ## Examples

      iex> get_cart!(123)
      %Cart{}

      iex> get_cart!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart!(%Scope{} = scope, id) do
    Repo.get_by!(Cart, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart(%Scope{} = scope, attrs) do
    with {:ok, cart = %Cart{}} <-
           %Cart{}
           |> Cart.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast(scope, {:created, cart})
      {:ok, cart}
    end
  end

  @doc """
  Updates a cart.

  ## Examples

      iex> update_cart(cart, %{field: new_value})
      {:ok, %Cart{}}

      iex> update_cart(cart, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart(%Scope{} = scope, %Cart{} = cart, attrs) do
    true = cart.user_id == scope.user.id

    with {:ok, cart = %Cart{}} <-
           cart
           |> Cart.changeset(attrs, scope)
           |> Repo.update() do
      broadcast(scope, {:updated, cart})
      {:ok, cart}
    end
  end

  @doc """
  Deletes a cart.

  ## Examples

      iex> delete_cart(cart)
      {:ok, %Cart{}}

      iex> delete_cart(cart)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart(%Scope{} = scope, %Cart{} = cart) do
    true = cart.user_id == scope.user.id

    with {:ok, cart = %Cart{}} <-
           Repo.delete(cart) do
      broadcast(scope, {:deleted, cart})
      {:ok, cart}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart changes.

  ## Examples

      iex> change_cart(cart)
      %Ecto.Changeset{data: %Cart{}}

  """
  def change_cart(%Scope{} = scope, %Cart{} = cart, attrs \\ %{}) do
    true = cart.user_id == scope.user.id

    Cart.changeset(cart, attrs, scope)
  end
end
