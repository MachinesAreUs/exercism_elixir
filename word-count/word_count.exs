defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
      |> remove_punctuation
      |> downcase
      |> get_words
      |> count_words
  end

  defp remove_punctuation(sentence), do: String.replace sentence, ~r/[!&@$%^&,.:;_]/, " "

  defp downcase(sentence), do: String.downcase sentence
  
  defp get_words(sentence), do: String.split sentence

  defp count_words(words) do
    Enum.reduce words, %{}, fn(w, acc) ->
      Map.put acc, w, (acc[w] || 0) + 1
    end 
  end
end
