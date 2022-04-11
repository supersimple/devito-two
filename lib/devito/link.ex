defmodule Devito.Link do
  @moduledoc """
  Schema for a link.
  """

  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Devito.Repo

  @primary_key {:short_code, :string, auto_generate: false}

  schema "links" do
    field :url, :string
    field :count, :integer, default: 0
    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :short_code, :count])
    |> validate_required([:url, :short_code, :count])
    |> validate_change(:url, &valid_uri?/2)
    |> unique_constraint(:links, name: :links_pkey)
  end

  def generate_short_code(retries \\ 5)
  def generate_short_code(0), do: nil

  def generate_short_code(retries) do
    short_code = do_generate_random_code()
    if valid_short_code?(short_code), do: short_code, else: generate_short_code(retries - 1)
  end

  def insert_link(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def find_link(short_code) do
    Repo.one(from(l in __MODULE__, where: l.short_code == ^ short_code))
  end

  def increment_count(short_code) do
    from(l in __MODULE__, update: [inc: [count: 1]], where: [short_code: ^short_code]) |> Repo.update_all([])
  end

  def all() do
    Repo.all(__MODULE__)
  end

  defp valid_uri?(field, value) do
    parsed = URI.parse(value)

    invalid? =
      is_nil(parsed.scheme) or is_nil(parsed.host) or parsed.scheme not in ["http", "https"]

    if invalid? do
      [{field, "expects a url starting with http or https"}]
    else
      []
    end
  end

  defp valid_short_code?(string) do
      string not in [nil, ""] and find_link(string) == nil
  end

  defp do_generate_random_code do
    short_code_chars = Application.get_env(:devito, :short_code_chars)

    Enum.reduce(0..5, [], fn _n, acc -> acc ++ Enum.take_random(short_code_chars, 1) end)
    |> List.to_string()
  end
end
