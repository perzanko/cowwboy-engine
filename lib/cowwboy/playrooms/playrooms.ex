defmodule Cowwboy.Playrooms do
  @moduledoc """
  The Playrooms context.
  """

  import Ecto.Query, warn: false
  alias Cowwboy.Repo

  alias Cowwboy.Playrooms.Playroom

  @doc """
  Returns the list of playrooms.

  ## Examples

      iex> list_playrooms()
      [%Playroom{}, ...]

  """
  def list_playrooms do
    Repo.all(Playroom)
  end

  @doc """
  Gets a single playroom.

  Raises `Ecto.NoResultsError` if the Playroom does not exist.

  ## Examples

      iex> get_playroom!(123)
      %Playroom{}

      iex> get_playroom!(456)
      ** (Ecto.NoResultsError)

  """
  def get_playroom!(id), do: Repo.get!(Playroom, id)

  @doc """
  Creates a playroom.

  ## Examples

      iex> create_playroom(%{field: value})
      {:ok, %Playroom{}}

      iex> create_playroom(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_playroom(attrs \\ %{}) do
    %Playroom{}
    |> Playroom.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a playroom.

  ## Examples

      iex> update_playroom(playroom, %{field: new_value})
      {:ok, %Playroom{}}

      iex> update_playroom(playroom, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_playroom(%Playroom{} = playroom, attrs) do
    playroom
    |> Playroom.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Playroom.

  ## Examples

      iex> delete_playroom(playroom)
      {:ok, %Playroom{}}

      iex> delete_playroom(playroom)
      {:error, %Ecto.Changeset{}}

  """
  def delete_playroom(%Playroom{} = playroom) do
    Repo.delete(playroom)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking playroom changes.

  ## Examples

      iex> change_playroom(playroom)
      %Ecto.Changeset{source: %Playroom{}}

  """
  def change_playroom(%Playroom{} = playroom) do
    Playroom.changeset(playroom, %{})
  end
end
