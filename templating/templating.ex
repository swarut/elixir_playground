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

  # def gen_ruby_main_file do

  # end

  # def gen_ruby do
  #   create_ruby_folder
  #   |> gen_ruby_main_file
  #   |> copy_gem_file
  #   |> run_bundle_install
  # end

  # def gen_elixir do
  #   run_mix_new_project(name)
  # end

end
