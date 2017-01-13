defmodule Til.Post do
  use Til.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :user, Til.User
    many_to_many :tags, Til.Tag, join_through: "posts_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
  end
end
