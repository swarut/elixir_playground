defmodule Templating do
  require EEx

  def gen_ruby(name) do
    IO.puts "Generating base Ruby code."
    System.cmd("mkdir", ["ruby"])
    System.cmd("mkdir", ["spec"], cd: "ruby")
    System.cmd("cp", ["src/Gemfile", "ruby"])
    System.cmd("cp", ["src/.rspec", "ruby"])
    System.cmd("cp", ["src/spec_helper.rb", "ruby/spec"])
    IO.puts "* Generating base source and spec."
    gen_ruby_main_file(name)
    gen_ruby_spec_file(name)

    IO.puts "* Running bundle"
    System.cmd("bundle", ["install"], cd: "ruby")
    IO.puts "::Completed::"
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
