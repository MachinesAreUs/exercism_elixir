defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter candidates, &(anagram(base, &1))
  end

  def anagram(word1, word2) do
    import String, only: [downcase: 1]
    Enum.sort(to_char_list(downcase(word1))) == Enum.sort(to_char_list(downcase(word2)))
      and downcase(word1) != downcase(word2)
  end
end
