defmodule Til.Tag do
  use Til.Web, :model

  schema "tags" do
    field :name, :string
    many_to_many :posts, Til.Post, join_through: "posts_tags"

    timestamps() end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end


end
