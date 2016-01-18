defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime
  def from(datetime) do
    datetime
      |> :calendar.datetime_to_gregorian_seconds()
      |> sum_gigasecond()
      |> round
      |> :calendar.gregorian_seconds_to_datetime
  end

  defp sum_gigasecond(num), do: num + :math.pow(10, 9)
end
