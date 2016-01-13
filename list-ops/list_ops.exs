defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([h|t]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse(l) do
    reduce l, [], fn(x, acc) -> [x|acc] end
  end

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h|t], f) do
    [f.(h)|map(t,f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    add_if_true = fn(x, acc) -> 
      case f.(x) do
        true -> [x|acc]
        _    -> acc
      end
    end
    reduce(l, [], add_if_true) |> reverse
 end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], b), do: b
  def append(a, []), do: a
  def append(a, b) do
    reduce reverse(a), b, fn(x, acc) -> [x|acc] end
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) do
    h ++ concat(t)
  end
end
