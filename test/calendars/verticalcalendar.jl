module test_calendars_verticalcalendar

using Test
using Calendars # VerticalCalendar Date

cal = VerticalCalendar(Date(2019,1,1), Date(2019,3,31))
@test sprint(show, cal) == """
    2019
    Jan         Feb         Mar
        6 13 20 27  3 10 17 24  3 10 17 24 31
Mon     7 14 21 28  4 11 18 25  4 11 18 25   
     1  8 15 22 29  5 12 19 26  5 12 19 26   
Wed  2  9 16 23 30  6 13 20 27  6 13 20 27   
     3 10 17 24 31  7 14 21 28  7 14 21 28   
Fri  4 11 18 25  1  8 15 22  1  8 15 22 29   
     5 12 19 26  2  9 16 23  2  9 16 23 30   """

end # module test_calendars_verticalcalendar
