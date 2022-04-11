defmodule DevitoWeb.API.LinkView do
  use DevitoWeb, :view

  def render("index.json", %{links: links}) do
    %{
      links: Enum.map(links, &link_json/1)
    }
  end

  def render("show.json", %{link: link}) do
    link_json(link)
  end

  def render("show.json", %{resp: resp}) do
    resp
  end

  defp link_json({_key, link}) do
    link_json(link)
  end

  defp link_json(link) do
    %{
      url: link.url,
      short_code: link.short_code,
      count: link.count,
      inserted_at: link.inserted_at
    }
  end
end
