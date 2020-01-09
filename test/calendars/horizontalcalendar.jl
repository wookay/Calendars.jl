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

jantomar = HorizontalCalendar(Date(2020,1,1), Date(2020,3,31))
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

end # module test_calendars_horizontalcalendar
