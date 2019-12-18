# Calendars.jl 🗓

|  **Build Status**                                               |
|:---------------------------------------------------------------:|
|  [![][travis-img]][travis-url]  [![][codecov-img]][codecov-url] |


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

julia> VerticalCalendar()
    2019
    Jun
        2  9 16 23 30
Mon     3 10 17 24
        4 11 18 25
Wed     5 12 19 26
        6 13 20 27
Fri     7 14 21 28
     1  8 15 22 29

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


[travis-img]: https://api.travis-ci.org/wookay/Calendars.jl.svg?branch=master
[travis-url]: https://travis-ci.org/wookay/Calendars.jl

[codecov-img]: https://codecov.io/gh/wookay/Calendars.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/wookay/Calendars.jl/branch/master
