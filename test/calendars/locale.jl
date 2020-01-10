module test_calendars_locale

using Test
using Calendars # HorizontalCalendar VerticalCalendar

jan2020 = HorizontalCalendar(Date(2020,1), locale="korean")
@test sprint(show, jan2020) == """
     일 월 화 수 목 금 토
1월            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27 28 29 30 31   """

jan2020 = VerticalCalendar(Date(2020,1), locale="korean")
@test sprint(show, jan2020) == """
    2020
    1월
        5 12 19 26
월      6 13 20 27
        7 14 21 28
수   1  8 15 22 29
     2  9 16 23 30
금   3 10 17 24 31
     4 11 18 25   """

jan2020 = HorizontalCalendar(Date(2020,1), locale="chinese")
@test sprint(show, jan2020) == """
     日 一 二 三 四 五 六
1月            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27 28 29 30 31   """

jan2020 = VerticalCalendar(Date(2020,1), locale="chinese")
@test sprint(show, jan2020) == """
    2020
    1月
        5 12 19 26
一      6 13 20 27
        7 14 21 28
三   1  8 15 22 29
     2  9 16 23 30
五   3 10 17 24 31
     4 11 18 25   """

end # module test_calendars_locale
