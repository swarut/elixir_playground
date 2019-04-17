defmodule Templating do
  require EEx
  def render(name) do
    {:ok, text} = File.read("template.eex")
    output = EEx.eval_string(text, name: name)
    File.write("output.rb", output)
  end


  def gen(name) do
    System.cmd("mkdir", ["ruby"])
    System.cmd("mkdir", ["spec"], cd: "ruby")
    System.cmd("cp", ["src/Gemfile", "ruby"])
    System.cmd("bundle", ["install"], cd: "ruby")
    gen_ruby_main_file(name)
    gen_ruby_spec_file(name)
  end

  def gen_ruby_main_file(name) do
    output = get_ruby_output("src/ruby_base.eex", name)
    File.write("ruby/#{name}.rb", output)
  end

  def gen_ruby_spec_file(name) do
    output = get_ruby_output("src/ruby_spec_base.eex", name)
    File.write("ruby/spec/#{name}_spec.rb", output)
  end

  def get_ruby_output(file_name, name) do
    {:ok, text} = File.read(file_name)
    class_name = String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join
    output = EEx.eval_string(text, name: name, class_name: class_name)
  end

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
