# module Calendars

export DateSpan, Date, Day, lastdayofmonth

using Dates: Dates, Date, Day, lastdayofmonth

"""
```julia
struct DateSpan
    dates::Vector{Date}
    color::Symbol
end
```
"""
struct DateSpan
    dates::Vector{Date}
    color::Symbol
end

function Dates.Date(y::Int, m::Int, ::typeof(lastdayofmonth))::Date
    lastdayofmonth(Date(y, m))
end

# module Calendars
