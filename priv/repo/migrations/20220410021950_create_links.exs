defmodule Devito.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :short_code, :string, primary_key: true
      add :url, :string, null: false
      add :count, :integer, default: 0

      timestamps(updated_at: false)
    end
  end
end
