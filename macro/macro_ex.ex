defmodule MacroEx do
  defmacro assign_var(var_atom) do
    var = Macro.var(var_atom, nil)
    out = "This is a string"
    quote do
      unquote(var) = unquote(out)
    end
  end

  def run do
    assign_var(:output)
    IO.puts(output)
  end
end
