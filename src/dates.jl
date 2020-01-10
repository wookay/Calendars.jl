# module Calendars

export DateSpan
export       Date, Year, Month, Week, Day, lastdayofmonth, today
using Dates: Date, Year, Month, Week, Day, lastdayofmonth, today

using Dates: Dates, firstdayofyear, lastdayofyear, firstdayofmonth, firstdayofweek, lastdayofweek, dayofweek

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

function Base.:(==)(a::DateSpan, b::DateSpan)
    a.dates == b.dates &&
    a.color == b.color
end

abstract type CalendarWall end

function (::Type{T})(startDate::Date,
                     endDate::Date ;
                     datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                     cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0))) where {T <: CalendarWall}
    T(startDate, endDate, datespans, cell)
end

function (::Type{T})(y::Year; kwargs...) where {T <: CalendarWall}
    date = Date(Dates.value(y))
    T(firstdayofyear(date), lastdayofyear(date); kwargs...)
end

function (::Type{T})(m::Month, date::Date=today(); kwargs...) where {T <: CalendarWall}
    val = Dates.value(m)
    if val > 0
        T(firstdayofmonth(date), lastdayofmonth(date + m - Month(1)); kwargs...)
    else
        T(firstdayofmonth(date + m), lastdayofmonth(date - Month(1)); kwargs...)
    end
end

function (::Type{T})(w::Week, date::Date=today(); kwargs...) where {T <: CalendarWall}
    val = Dates.value(w)
    if val > 0
        T(firstdayofweek(date), lastdayofweek(date + w - Week(1)); kwargs...)
    else
        T(firstdayofweek(date + w), lastdayofweek(date - Week(1)); kwargs...)
    end
end

function (::Type{T})(d::Day, date::Date=today(); kwargs...) where {T <: CalendarWall}
    val = Dates.value(d)
    if val > 0
        T(date, date + d; kwargs...)
    else
        T(date + d, date; kwargs...)
    end
end

function (::Type{T})(date::Date; kwargs...) where {T <: CalendarWall}
    T(firstdayofmonth(date), lastdayofmonth(date); kwargs...)
end

function (::Type{T})() where {T <: CalendarWall}
    T(today())
end


function Dates.Date(y::Int, m::Int, ::typeof(lastdayofmonth))::Date
    lastdayofmonth(Date(y, m))
end

# module Calendars
