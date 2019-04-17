defmodule Templating do
  require EEx
  def render(name) do
    {:ok, text} = File.read("template.eex")
    output = EEx.eval_string(text, name: name)
    File.write("output.rb", output)
  end

  def gen(name) do
    System.cmd("mkdir", ["ruby"])
    {:ok, text} = File.read("template.eex")
    output = EEx.eval_string(text, name: name)
    File.write("ruby/output.rb", output)
    System.cmd("cp", ["src/Gemfile", "ruby"])
    System.cmd("bundle", ["install"], cd: "ruby")
  end

end
