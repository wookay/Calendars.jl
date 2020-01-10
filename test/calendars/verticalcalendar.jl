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

jan2020 = VerticalCalendar(Date(2020,1))
@test sprint(show, jan2020) == """
    2020
    Jan
        5 12 19 26
Mon     6 13 20 27
        7 14 21 28
Wed  1  8 15 22 29
     2  9 16 23 30
Fri  3 10 17 24 31
     4 11 18 25   """

mar2020 = VerticalCalendar(Date(2020,3))
@test sprint(show, mar2020) == """
    2020
    Mar
     1  8 15 22 29
Mon  2  9 16 23 30
     3 10 17 24 31
Wed  4 11 18 25   
     5 12 19 26   
Fri  6 13 20 27   
     7 14 21 28   """

@test VerticalCalendar(Year(2020)) isa VerticalCalendar

dec2019_to_jan2020 = VerticalCalendar(Month(2), Date(2020,1)-Month(1))
@test sprint(show, dec2019_to_jan2020) == """
    2019        2020
    Dec         Jan
     1  8 15 22 29  5 12 19 26
Mon  2  9 16 23 30  6 13 20 27
     3 10 17 24 31  7 14 21 28
Wed  4 11 18 25  1  8 15 22 29
     5 12 19 26  2  9 16 23 30
Fri  6 13 20 27  3 10 17 24 31
     7 14 21 28  4 11 18 25   """

twomonthago = VerticalCalendar(-Month(2), Date(2020,1))
@test sprint(show, twomonthago) == """
    2019
    Nov            Dec
        3 10 17 24  1  8 15 22 29
Mon     4 11 18 25  2  9 16 23 30
        5 12 19 26  3 10 17 24 31
Wed     6 13 20 27  4 11 18 25   
        7 14 21 28  5 12 19 26   
Fri  1  8 15 22 29  6 13 20 27   
     2  9 16 23 30  7 14 21 28   """

week1 = VerticalCalendar(Week(1), Date(2020,1,1))
@test sprint(show, week1) == """
    2020
    Jan
        5
Mon 30   
    31   
Wed  1   
     2   
Fri  3   
     4   """

prevweek1 = VerticalCalendar(-Week(1), Date(2020,1,1))
@test sprint(show, prevweek1) == """
    2019
    Dec
       29
Mon 23   
    24   
Wed 25   
    26   
Fri 27   
    28   """

day100 = VerticalCalendar(Day(100), Date(2020,1,1))
@test sprint(show, day100) == """
    2020
    Jan         Feb            Mar         Apr
        5 12 19 26  2  9 16 23  1  8 15 22 29  5
Mon     6 13 20 27  3 10 17 24  2  9 16 23 30  6
        7 14 21 28  4 11 18 25  3 10 17 24 31  7
Wed  1  8 15 22 29  5 12 19 26  4 11 18 25  1  8
     2  9 16 23 30  6 13 20 27  5 12 19 26  2  9
Fri  3 10 17 24 31  7 14 21 28  6 13 20 27  3 10
     4 11 18 25  1  8 15 22 29  7 14 21 28  4   """

# JuliaCon 2020, Lisbon, Portugal
dday100 = VerticalCalendar(-Day(100), Date(2020,7,27)) # Monday 27th to Friday 31st of July, 2020
@test sprint(show, dday100) == """
          2020
          May            Jun         Jul
       19 26  3 10 17 24 31  7 14 21 28  5 12 19 26
Mon    20 27  4 11 18 25  1  8 15 22 29  6 13 20 27
       21 28  5 12 19 26  2  9 16 23 30  7 14 21   
Wed    22 29  6 13 20 27  3 10 17 24  1  8 15 22   
       23 30  7 14 21 28  4 11 18 25  2  9 16 23   
Fri    24  1  8 15 22 29  5 12 19 26  3 10 17 24   
    18 25  2  9 16 23 30  6 13 20 27  4 11 18 25   """

juliacon2020 = VerticalCalendar(Date(2020, 7), datespans=[DateSpan(Date(2020,7,27):Day(1):Date(2020,7,31), :green)])
@test sprint(show, juliacon2020) == """
    2020
    Jul
        5 12 19 26
Mon     6 13 20 27
        7 14 21 28
Wed  1  8 15 22 29
     2  9 16 23 30
Fri  3 10 17 24 31
     4 11 18 25   """

end # module test_calendars_verticalcalendar
