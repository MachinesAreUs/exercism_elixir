defmodule HelloWorld do

  # Elixir counts the number of arguments as part of the function name.
  # For instance,

    #def hello() do
    #end

  # would be a completely different function from

    #def hello(name) do
    #end

  # Can you find a way to make all the tests pass with just one function?
  # Hint: look into argument defaults here:
  # http://elixir-lang.org/getting-started/modules.html#default-arguments

  def hello(name \\ nil) do
    if name == nil do "Hello, World!" else "Hello, #{name}!" end
  end
end
