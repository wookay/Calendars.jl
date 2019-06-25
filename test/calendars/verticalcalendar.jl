module test_calendars_verticalcalendar

using Test
using Calendars # VerticalCalendar DateSpan Date

cal1 = VerticalCalendar(Date(2019,1,1), Date(2019,3,31))
cal2 = VerticalCalendar(Date(2019,1,1), Date(2019,3,31), datespans=[DateSpan([Date(2019,2,15)], :cyan)])
@test sprint(show, cal1) == sprint(show, cal2) == """
    2019
    Jan         Feb         Mar
        6 13 20 27  3 10 17 24  3 10 17 24 31
Mon     7 14 21 28  4 11 18 25  4 11 18 25   
     1  8 15 22 29  5 12 19 26  5 12 19 26   
Wed  2  9 16 23 30  6 13 20 27  6 13 20 27   
     3 10 17 24 31  7 14 21 28  7 14 21 28   
Fri  4 11 18 25  1  8 15 22  1  8 15 22 29   
     5 12 19 26  2  9 16 23  2  9 16 23 30   """

cal3 = VerticalCalendar(Date(2018,11,12), Date(2019,2,15), cell=(size=(2, 1), margin=(2, 1)))
@test sprint(show, cal3) == """
            2018                2019
            Dec                 Jan             Feb 
        18  25   2   9  16  23  30   6  13  20  27   3  10
Mon 12  19  26   3  10  17  24  31   7  14  21  28   4  11
    13  20  27   4  11  18  25   1   8  15  22  29   5  12
Wed 14  21  28   5  12  19  26   2   9  16  23  30   6  13
    15  22  29   6  13  20  27   3  10  17  24  31   7  14
Fri 16  23  30   7  14  21  28   4  11  18  25   1   8  15
    17  24   1   8  15  22  29   5  12  19  26   2   9    """

cal4 = VerticalCalendar(Date(2018,11,12), Date(2018,11,15))
@test sprint(show, cal4) == """
    2018
    Nov
      
Mon 12
    13
Wed 14
    15
Fri   
      """

end # module test_calendars_verticalcalendar
