# module Calendars

export VerticalCalendar, Date, DateSpan, Day

using Dates: ENGLISH, DatePeriod, Date, Month, Week, Day, firstdayofmonth, lastdayofmonth, firstdayofweek, year, month, day, today

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

"""
    VerticalCalendar(startDate::Date,
                     endDate::Date ;
                     datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                     cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)))

    VerticalCalendar(d::Date)

    VerticalCalendar()

```julia
struct VerticalCalendar
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}
end
```
"""
struct VerticalCalendar
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}

    function VerticalCalendar(startDate::Date,
                              endDate::Date ;
                              datespans::Vector{DateSpan}=[DateSpan([today()], :cyan)],
                              cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)))
        new(startDate, endDate, datespans, cell)
    end

    function VerticalCalendar(d::Date)
        VerticalCalendar(firstdayofmonth(d), lastdayofmonth(d))
    end

    function VerticalCalendar()
        VerticalCalendar(today())
    end
end

function Base.show(io::IO, cal::VerticalCalendar)
    sunday = firstdayofweek(cal.startDate) - Day(1)
    grid = mapfoldl(hcat, sunday:Week(1):cal.endDate, init=Array{Date, 2}(undef, 7, 0)) do sun
        sun:Day(1):(sun + Day(6))
    end
    (rows, cols) = size(grid)
    th_years = []
    th_months = []
    daysofweek = Dict(map([2, 4, 6]) do nth
        (nth, ENGLISH.days_of_week_abbr[nth-1])
    end)
    for col in 1:cols
        nth = findfirst(d -> day(d) == 1, grid[:, col])
        if nth !== nothing
            firstday = grid[:, col][nth]
            if cal.startDate <= firstday <= cal.endDate
                m = ENGLISH.months_abbr[month(firstday)]
                push!(th_years, (col, year(firstday)))
                push!(th_months, (col, m))
            end
        end
    end
    if isempty(th_months)
        firstday = cal.startDate
        push!(th_years, (1, year(firstday)))
        push!(th_months, (1, ENGLISH.months_abbr[month(firstday)]))
    end

    cellwidth = cal.cell.size[1] + cal.cell.margin[1]
    leftside = 4
    prev_col = 0
    prev_year = nothing
    diff = 4 - cellwidth
    diff < 0 && (diff = 0)
    print(io, repeat(' ', leftside))
    (col, y) = first(th_years)
    n = cellwidth * (col - prev_col - 1) - diff
    n > 0 && print(io, repeat(' ', diff))
    for (col, y) in th_years
        if prev_year != y
            n = cellwidth * (col - prev_col - 1) - diff
            n > 0 && print(io, repeat(' ', n))
            print(io, rpad(string(y), cellwidth, ' '))
            prev_col = col
            prev_year = y
        end
    end
    println(io)

    prev_col = 0
    diff = 3 - cellwidth
    diff < 0 && (diff = 0)
    print(io, repeat(' ', leftside + diff))
    for (idx, (col, month)) in enumerate(th_months)
        n = cellwidth * (col - prev_col - 1) - diff
        print(io, repeat(' ', n))
        print(io, rpad(month, cellwidth, ' '))
        prev_col = col
    end
    println(io)

    colormap = Dict{Date,Symbol}()
    for span in cal.datespans, date in span.dates
        colormap[date] = span.color
    end
    for row in 1:rows
        if haskey(daysofweek, row)
            print(io, daysofweek[row], ' ')
        else
            print(io, repeat(' ', leftside))
        end
        days = grid[row, :]
        len = length(days)
        for (idx, d) in enumerate(days)
            if cal.startDate <= d <= cal.endDate
                str = lpad((string ∘ day)(d), cal.cell.size[1], ' ')
                if haskey(colormap, d)
                    printstyled(io, str, color=colormap[d])
                else
                    print(io, str)
                end
            else
                print(io, repeat(' ', cal.cell.size[1]))
            end
            idx < len && print(io, repeat(' ', cal.cell.margin[1]))
        end
        row < rows && println(io)
    end
end

# module Calendars
