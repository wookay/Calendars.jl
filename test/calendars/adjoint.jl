module test_calendars_adjoint

using Test
using Calendars # VerticalCalendar HorizontalCalendar

cal = VerticalCalendar(Date(2020,1))
@test cal' == HorizontalCalendar(Date(2020,1))
@test cal'' == cal

end # module test_calendars_adjoint
