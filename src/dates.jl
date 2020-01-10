# module Calendars

export       Date, Year, Month, Week, Day, lastdayofmonth, today
using Dates: Date, Year, Month, Week, Day, lastdayofmonth, today

using Dates: Dates, firstdayofyear, lastdayofyear, firstdayofmonth, firstdayofweek, lastdayofweek, dayofweek, monthabbr, dayabbr, year, month, day

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

abstract type CalendarWall end

"""
    VerticalCalendar(startDate::Date,
                     endDate::Date ;
                     datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                     cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)),
                     locale::AbstractString="english")

    VerticalCalendar(y::Year)

    VerticalCalendar(m::Month, date::Date=today())

    VerticalCalendar(w::Week, date::Date=today())

    VerticalCalendar(d::Day, date::Date=today())

    VerticalCalendar(date::Date)

    VerticalCalendar()

```julia
struct VerticalCalendar <: CalendarWall
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}
    locale::String
end
```
"""
struct VerticalCalendar <: CalendarWall
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}
    locale::String
end

"""
    HorizontalCalendar(startDate::Date,
                       endDate::Date ;
                       datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                       cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)),
                       locale::AbstractString="english")

    HorizontalCalendar(y::Year)

    HorizontalCalendar(m::Month, date::Date=today())

    HorizontalCalendar(w::Week, date::Date=today())

    HorizontalCalendar(d::Day, date::Date=today())

    HorizontalCalendar(date::Date)

    HorizontalCalendar()

```julia
struct HorizontalCalendar <: CalendarWall
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}
    locale::String
end
```
"""
struct HorizontalCalendar <: CalendarWall
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}
    locale::String
end

function (::Type{T})(startDate::Date,
                     endDate::Date ;
                     datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                     cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)),
                     locale::AbstractString="english") where {T <: CalendarWall}
    T(startDate, endDate, datespans, cell, locale)
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

function (::Type{T})(; kwargs...) where {T <: CalendarWall}
    T(today(); kwargs...)
end

function Base.adjoint(cal::VerticalCalendar)::HorizontalCalendar
    HorizontalCalendar(getfield.(Ref(cal), fieldnames(HorizontalCalendar))...)
end

function Base.adjoint(cal::HorizontalCalendar)::VerticalCalendar
    VerticalCalendar(getfield.(Ref(cal), fieldnames(VerticalCalendar))...)
end

function Base.:(==)(a::T, b::T) where {T <: CalendarWall}
    getfield.(Ref(a), fieldnames(T)) == getfield.(Ref(b), fieldnames(T))
end

function Base.:(==)(a::T, b::T) where {T <: DateSpan}
    getfield.(Ref(a), fieldnames(T)) == getfield.(Ref(b), fieldnames(T))
end


function Dates.Date(y::Int, m::Int, ::typeof(lastdayofmonth))::Date
    lastdayofmonth(Date(y, m))
end

const KOREAN = Dates.DateLocale(
    split("일월 이월 삼월 사월 오월 유월 칠월 팔월 구월 시월 십일월 십이월", ' '),
    split("1월 2월 3월 4월 5월 6월 7월 8월 9월 10월 11월 12월", ' '),
    split("월요일 화요일 수요일 목요일 금요일 토요일 일요일", ' '),
    split("월 화 수 목 금 토 일", ' '),
)

const CHINESE = Dates.DateLocale(
    split("一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月", ' '),
    split("1月 2月 3月 4月 5月 6月 7月 8月 9月 10月 11月 12月", ' '),
    split("星期一 星期二 星期三 星期四 星期五 星期六 星期日", ' '),
    split("一 二 三 四 五 六 日", ' '),
)

function __init__()
    merge!(Dates.LOCALES, Dict(
        "korean" => KOREAN,
        "chinese" => CHINESE,
    ))
end

function dayabbrshort(day::Integer; locale::AbstractString="english")
    abbr = dayabbr.(Dates.Mon:Dates.Sun, locale=locale)[day]
    length(abbr) > 2 ? SubString(abbr, 1, 2) : abbr
end

# module Calendars
