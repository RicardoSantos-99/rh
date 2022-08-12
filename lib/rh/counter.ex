defmodule Rh.Counter do
  use Agent

  def start_link(initial_value, name) do
    Agent.start_link(fn -> initial_value end, name: name)
  end

  def value do
    Agent.get(:Teste, & &1)
  end

  def increment do
    Agent.update(:Teste, &(&1 + 1))
    Agent.get(:Teste, & &1)
  end
end
