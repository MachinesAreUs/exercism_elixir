defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekday_number %{
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday
  }

  @schedule_ord %{first: 1, second: 2, third:  3, fourth: 4}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {year, month, calculate_day(year, month, weekday, schedule)}
  end

  defp calculate_day(year, month, weekday, :teenth) do
    thirteenth_day_of_the_month = @weekday_number[:calendar.day_of_the_week({year, month, 13})]
    count_until_weekday(13, thirteenth_day_of_the_month, weekday, 1)
  end

  defp calculate_day(year, month, weekday, :last) do
    days_in_month = :calendar.last_day_of_the_month(year, month)
    last_day_of_the_month = @weekday_number[:calendar.day_of_the_week({year, month, days_in_month})]
    count_until_weekday(days_in_month, last_day_of_the_month, weekday)
  end

  defp calculate_day(year, month, weekday, schedule) do
    first_day_of_the_month = @weekday_number[:calendar.day_of_the_week({year, month, 1})]
    count_until_weekday(1, first_day_of_the_month, weekday, @schedule_ord[schedule]) 
  end

  defp count_until_weekday(from_day_n, from_day, to_day, occurrence) do
    cond do
      from_day == to_day and occurrence == 1 ->
        from_day_n
      from_day == to_day and occurrence != 1 ->
        count_until_weekday(from_day_n + 1, next_day(from_day), to_day, occurrence - 1)
      true ->
        count_until_weekday(from_day_n + 1, next_day(from_day), to_day, occurrence)
    end
  end

  defp count_until_weekday(from_day_n, from_day, to_day) do
    from_day == to_day && from_day_n || count_until_weekday(from_day_n - 1, prev_day(from_day), to_day)
  end

  @week_days Map.values(@weekday_number)

  defp prev_day(day) do
    @week_days
      |> Enum.reverse
      |> Stream.cycle
      |> Stream.drop_while(&(&1 != day))
      |> Stream.drop(1) 
      |> Enum.at(0)
  end

  defp next_day(day) do
    @week_days
      |> Stream.cycle
      |> Stream.drop_while(&(&1 != day))
      |> Stream.drop(1) 
      |> Enum.at(0)
  end
end
