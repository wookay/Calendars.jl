# Calendars.jl

|  **Build Status**                                               |
|:---------------------------------------------------------------:|
|  [![][travis-img]][travis-url]  [![][codecov-img]][codecov-url] |


```
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
```


[travis-img]: https://api.travis-ci.org/wookay/Calendars.jl.svg?branch=master
[travis-url]: https://travis-ci.org/wookay/Calendars.jl

[codecov-img]: https://codecov.io/gh/wookay/Calendars.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/wookay/Calendars.jl/branch/master
