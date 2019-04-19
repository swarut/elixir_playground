defmodule Qq do
  defmacro mac(atom_name) do
    name = Atom.to_string(atom_name)
    var = Macro.var(atom_name, nil)
    rendered_content = "oh my god"

    {:ok, text} = File.read("src/ruby_base.eex")

    out = EEx.eval_string(text, name: name, class_name: "classname")
    quote do
      # unquote(var) = unquote(rendered_content)
      unquote(var) = unquote(out)
    end
  end

  def run do
    mac(:output)
    IO.puts(output)
  end
end
