defmodule Phone do

  @wrong_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    clean = String.replace raw, ~r/[\(\)-\.\s]/, ""
    cond do
      String.length(clean) == 10 and all_digits?(clean) -> 
        clean
      String.length(clean) == 11 and String.starts_with?(clean, "1") -> 
        String.replace(clean, "1", "", global: false)
      true -> 
        @wrong_number
    end
  end

  defp all_digits?(str), do: String.match? str, ~r/^[0-9]{10}$/

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    num = number(raw)
    case num == @wrong_number do
      true -> "000" 
      _    -> String.slice num, 0, 3
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    num        = number(raw)
    exchange   = String.slice num, 3, 3
    subscriber = String.slice num, 6, 4
    "(#{area_code(num)}) #{exchange}-#{subscriber}"
  end
end
