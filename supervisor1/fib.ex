defmodule Fib do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:fib, _from, all = [last | [before_last | tail]]) do
    IO.puts "Current state = #{inspect all}"
    new_value = last + before_last
    if length(all) == 4 do
      raise "no more than 4"
    end
    {:reply, new_value, [new_value | all]}
  end

  def start do
    child = [{Fib, [1, 0]}]
    {:ok, pid} = Supervisor.start_link(child, strategy: :one_for_one)

    Enum.each(1..20, fn x ->
      IO.puts GenServer.call(Fib, :fib)
    end)
  end
end




















# defmodule FibSupervisor do
#   use Supervisor

#   def start_link(init_arg) do
#     {:ok, pid} = Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
#     # IO.puts("supervisor pid = #{inspect pid}")
#   end

#   @impl true
#   def init(_init_arg) do
#     children = [
#       {Fib, [0, 1]}
#     ]

#     {:ok, pid} = Supervisor.init(children, strategy: :one_for_one)
#     IO.puts "started child pid = #{inspect pid}"
#     {:ok, pid}
#   end
# end
