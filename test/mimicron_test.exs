defmodule Usage do
  use Mimicron

  def sample, do: 1
end

defmodule MimicronTest do
  use ExUnit.Case
  doctest Mimicron

  test "usage sample" do
    assert Usage.sample() == 1
  end
end
