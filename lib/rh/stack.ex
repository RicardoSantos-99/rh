defmodule Rh.Stack do
  use GenServer

  # Client
  def start_link(stack) when is_list(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def push(element) do
    GenServer.call(__MODULE__, {:push, element})
  end

  def async_push(element) do
    GenServer.call(__MODULE__, {:push, element})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def show do
    GenServer.call(__MODULE__, :show)
  end

  # Server
  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call({:push, element}, _from, state) do
    {:reply, [element | state], [element | state]}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl true
  def handle_call(:show, _from, stack) do
    {:reply, stack, stack}
  end

  # ASYNC
  @impl true
  def handle_cast({:push, element}, stack) do
    {:noreply, [element | stack]}
  end
end
