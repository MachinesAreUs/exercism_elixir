defmodule Bob do
  import String

  def hey(input) do
    cond do
        is_question?(input) -> "Sure."
        is_silence?(input)  -> "Fine. Be that way!"
        is_shout?(input)    -> "Whoa, chill out!"
        true                -> "Whatever."
    end
  end

  defp is_question?(input),     do: ends_with? input, "?"
  defp is_silence?(input),      do: strip(input) == ""
  defp is_shout?(input),        do: is_all_capitals?(input) and has_letters?(input)
  defp is_all_capitals?(input), do: upcase(input) == input
  defp has_letters?(input),     do: Regex.match? ~r/[A-ZА-Я]+/, input
end
