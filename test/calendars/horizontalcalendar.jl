module test_calendars_horizontalcalendar

using Test
using Calendars # HorizontalCalendar

jan2020 = HorizontalCalendar(Date(2020,1))
@test sprint(show, jan2020) == """
     Su Mo Tu We Th Fr Sa
Jan            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27 28 29 30 31   """

mar2020 = HorizontalCalendar(Date(2020,3))
@test sprint(show, mar2020) == """
     Su Mo Tu We Th Fr Sa
Mar   1  2  3  4  5  6  7
2020  8  9 10 11 12 13 14
     15 16 17 18 19 20 21
     22 23 24 25 26 27 28
     29 30 31            """

jantomar = HorizontalCalendar(Date(2020,1,1), Date(2020,3,lastdayofmonth))
@test sprint(show, jantomar) == """
     Su Mo Tu We Th Fr Sa
Jan            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
Feb  26 27 28 29 30 31  1
      2  3  4  5  6  7  8
      9 10 11 12 13 14 15
     16 17 18 19 20 21 22
     23 24 25 26 27 28 29
Mar   1  2  3  4  5  6  7
      8  9 10 11 12 13 14
     15 16 17 18 19 20 21
     22 23 24 25 26 27 28
     29 30 31            """

@test HorizontalCalendar(Year(2020)) isa HorizontalCalendar

twomonthago = HorizontalCalendar(-Month(2), Date(2020,1))
@test sprint(show, twomonthago) == """
     Su Mo Tu We Th Fr Sa
Nov                  1  2
2019  3  4  5  6  7  8  9
     10 11 12 13 14 15 16
     17 18 19 20 21 22 23
     24 25 26 27 28 29 30
Dec   1  2  3  4  5  6  7
      8  9 10 11 12 13 14
     15 16 17 18 19 20 21
     22 23 24 25 26 27 28
     29 30 31            """

week1 = HorizontalCalendar(Week(1), Date(2020,1,1))
@test sprint(show, week1) == """
     Su Mo Tu We Th Fr Sa
Jan     30 31  1  2  3  4
2020  5                  """

prevweek1 = HorizontalCalendar(-Week(1), Date(2020,1,1))
@test sprint(show, prevweek1) == """
     Su Mo Tu We Th Fr Sa
Dec     23 24 25 26 27 28
2019 29                  """

day100 = HorizontalCalendar(Day(100), Date(2020,1,1))
@test sprint(show, day100) == """
     Su Mo Tu We Th Fr Sa
Jan            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
Feb  26 27 28 29 30 31  1
      2  3  4  5  6  7  8
      9 10 11 12 13 14 15
     16 17 18 19 20 21 22
     23 24 25 26 27 28 29
Mar   1  2  3  4  5  6  7
      8  9 10 11 12 13 14
     15 16 17 18 19 20 21
     22 23 24 25 26 27 28
Apr  29 30 31  1  2  3  4
      5  6  7  8  9 10   """

# JuliaCon 2020, Lisbon, Portugal
dday100 = HorizontalCalendar(-Day(100), Date(2020,7,27)) # Monday 27th to Friday 31st of July, 2020
@test sprint(show, dday100) == """
     Su Mo Tu We Th Fr Sa
                       18
     19 20 21 22 23 24 25
May  26 27 28 29 30  1  2
2020  3  4  5  6  7  8  9
     10 11 12 13 14 15 16
     17 18 19 20 21 22 23
     24 25 26 27 28 29 30
Jun  31  1  2  3  4  5  6
      7  8  9 10 11 12 13
     14 15 16 17 18 19 20
     21 22 23 24 25 26 27
Jul  28 29 30  1  2  3  4
      5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27               """

juliacon2020 = HorizontalCalendar(Date(2020, 7), datespans=[DateSpan(Date(2020,7,27):Day(1):Date(2020,7,31), :green)])
@test sprint(show, juliacon2020) == """
     Su Mo Tu We Th Fr Sa
Jul            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27 28 29 30 31   """

end # module test_calendars_horizontalcalendar
