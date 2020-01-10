# Calendars.jl 🗓

|  **Documentation**                        |  **Build Status**                 |
|:------------------------------------------|-----------------------------------|
|  [![][docs-latest-img]][docs-latest-url]  |  [![][actions-img]][actions-url]  |


### Install

`julia>` type `]` key

```julia
(v1.3) pkg> add https://github.com/wookay/Calendars.jl.git
```


### VerticalCalendar

```julia
julia> using Calendars

julia> VerticalCalendar(Date(2019,1,1), Date(2019,3,31))
    2019
    Jan         Feb         Mar
        6 13 20 27  3 10 17 24  3 10 17 24 31
Mon     7 14 21 28  4 11 18 25  4 11 18 25
     1  8 15 22 29  5 12 19 26  5 12 19 26
Wed  2  9 16 23 30  6 13 20 27  6 13 20 27
     3 10 17 24 31  7 14 21 28  7 14 21 28
Fri  4 11 18 25  1  8 15 22  1  8 15 22 29
     5 12 19 26  2  9 16 23  2  9 16 23 30

julia> VerticalCalendar(Date(2020,1))
    2020
    Jan
        5 12 19 26
Mon     6 13 20 27
        7 14 21 28
Wed  1  8 15 22 29
     2  9 16 23 30
Fri  3 10 17 24 31
     4 11 18 25

julia> VerticalCalendar(Date(2018,11,15), Date(2019,3,20), datespans=[DateSpan(Date(2018,12,25):Day(1):Date(2019,1,2), :green)])
          2018           2019
          Dec            Jan         Feb         Mar
       18 25  2  9 16 23 30  6 13 20 27  3 10 17 24  3 10 17
Mon    19 26  3 10 17 24 31  7 14 21 28  4 11 18 25  4 11 18
       20 27  4 11 18 25  1  8 15 22 29  5 12 19 26  5 12 19
Wed    21 28  5 12 19 26  2  9 16 23 30  6 13 20 27  6 13 20
    15 22 29  6 13 20 27  3 10 17 24 31  7 14 21 28  7 14
Fri 16 23 30  7 14 21 28  4 11 18 25  1  8 15 22  1  8 15
    17 24  1  8 15 22 29  5 12 19 26  2  9 16 23  2  9 16
```


### HorizontalCalendar

```julia
julia> using Calendars

julia> HorizontalCalendar(Date(2020,1))
     Su Mo Tu We Th Fr Sa
Jan            1  2  3  4
2020  5  6  7  8  9 10 11
     12 13 14 15 16 17 18
     19 20 21 22 23 24 25
     26 27 28 29 30 31
```

### Times

```julia
using Calendars.Times

Day(0.5) + Hour(0.5) + Minute(0.5) == Hour(12) + Minute(30) + Second(30)

Minute(1) + Second(1) < Minute(1) + Second(2)
```


### LunarCalendars

 * Based on wolfhong's [LunarCalendar converter.py](https://github.com/wolfhong/LunarCalendar/blob/master/lunarcalendar/converter.py)

```julia
julia> using Calendars.LunarCalendars

julia> Lunar(Date(2020, 4, 23))
Lunar(2020, 4, 1, false)

julia> Lunar(Date(2020, 5, 23))
Lunar(2020, 4, 1, true)
```


[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://wookay.github.io/docs/Calendars.jl/

[actions-img]: https://github.com/wookay/Calendars.jl/workflows/CI/badge.svg
[actions-url]: https://github.com/wookay/Calendars.jl/actions
