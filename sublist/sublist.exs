defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare([],_), do: :sublist
  def compare(_,[]), do: :superlist
  def compare(a, b) do
    case sublist? a, b do
      true -> :sublist
      _    -> case sublist? b, a do
                true -> :superlist
                _    -> :unequal
              end
    end
  end

  defp sublist?(a,b) do
    Stream.with_index(b) 
      |> Stream.filter(fn({_x,idx}) -> sublist_from_idx?(a, b, idx) end)
      |> not_empty?
  end

  defp sublist_from_idx?(a, b, b_idx) do
    b_rem = Enum.drop(b, b_idx)
    length(b_rem) >= length(a) 
      and 
    Enum.zip(a, b_rem) |> Enum.all?(fn({x,y}) -> x === y end)
  end

  defp not_empty?(l), do: not Enum.empty?(l)
end
