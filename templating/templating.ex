defmodule Templating do
  require EEx
  def render(name) do
    {:ok, text} = File.read("template.eex")
    output = EEx.eval_string(text, name: name)
    File.write("output.rb", output)
  end

end
