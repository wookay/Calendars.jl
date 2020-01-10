module test_calendars_dates

using Test
using Calendars # DateSpan

datespan = DateSpan(Date(2020,7,27):Day(1):Date(2020,7,31), :green)
@test datespan == DateSpan([Date(2020,7,27), Date(2020,7,28), Date(2020,7,29), Date(2020,7,30), Date(2020,7,31)], :green)

end # module test_calendars_dates
