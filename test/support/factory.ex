defmodule Devito.Test.Factory do
  use ExMachina.Ecto, repo: Devito.Repo

  def link_factory do
    %Devito.Link{
      url: Faker.Internet.url(),
      short_code: Faker.String.base64(6),
      count: Faker.random_between(0, 50)
    }
  end
end
