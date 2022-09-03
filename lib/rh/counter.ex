defmodule Rh.Counter do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value(name) do
    Agent.get(name, & &1)
  end

  def increment(name) do
    Agent.update(name, &(&1 + 1))
    Agent.get(name, & &1)
  end

  def decrement(name) do
    Agent.update(name, &(&1 - 1))
    Agent.get(name, & &1)
  end
end
