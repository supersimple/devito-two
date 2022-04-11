defmodule Devito.LinkTest do
  use Devito.DataCase

  alias Devito.Link

  describe "generate_short_code/0" do
    test "creates a 6 character short code" do
      short_code = Link.generate_short_code()
      assert String.length(short_code) == 6
    end
  end
end
