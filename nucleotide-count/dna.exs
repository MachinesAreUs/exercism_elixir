defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if !nucleotide?(nucleotide) or !valid_strand?(strand), do: raise ArgumentError
    Enum.reduce strand, 0, fn(x, count) -> 
      x == nucleotide && (count + 1) || count
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Dict.t
  def histogram(strand) do
    if !valid_strand?(strand), do: raise ArgumentError
    Enum.reduce strand, %{?A => 0, ?C => 0, ?G => 0, ?T => 0}, fn(x, count) ->
      Map.put count, x, ((count[x] || 0) + 1)
    end
  end

  defp nucleotide?(n) do
    Enum.find(@nucleotides, &(&1 == n))
  end
  
  defp valid_strand?(strand) do
    Enum.all?(strand, &nucleotide?(&1))
  end
end
