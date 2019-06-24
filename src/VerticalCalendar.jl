# module Calendars

export VerticalCalendar, Date, Span, Day

using Dates: ENGLISH, DatePeriod, Date, Month, Week, Day, firstdayofmonth, lastdayofmonth, firstdayofweek, year, month, day, today

struct Span
    dates::Vector{Date}
    color::Symbol
end

struct VerticalCalendar
    startDate::Date
    endDate::Date
    spans::Vector{Span}
    function VerticalCalendar(startDate::Date, endDate::Date, spans::Vector{Span}=Span[])
        new(startDate, endDate, spans)
    end
    function VerticalCalendar()
        d = today()
        VerticalCalendar(firstdayofmonth(d), lastdayofmonth(d), [Span([d], :cyan)])
    end
end

function Base.show(io::IO, cal::VerticalCalendar)
    sunday = firstdayofweek(cal.startDate) - Day(1)
    grid = mapfoldl(hcat, sunday:Week(1):cal.endDate) do sun
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

    leftside = 4
    prev_col = 0
    prev_year = nothing
    print(io, repeat(' ', leftside))
    for (col, year) in th_years
        if prev_year != year
            n = 3col - 3prev_col - (prev_year === nothing ? 3 : 4)
            print(io, repeat(' ', n))
            print(io, rpad(string(year), 4))
            prev_col = col
            prev_year = year
        end
    end
    println(io)

    prev_col = 0
    print(io, repeat(' ', leftside))
    for (col, month) in th_months
        print(io, repeat(' ', 3col - 3prev_col - 3))
        print(io, string(month))
        prev_col = col
    end
    println(io)

    colormap = Dict{Date,Symbol}()
    for span in cal.spans, date in span.dates
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
                str = lpad((string ∘ day)(d), 2)
                if haskey(colormap, d)
                    printstyled(io, str, color=colormap[d])
                else
                    print(io, str)
                end
            else
                print(io, "  ")
            end
            idx < len && print(io, ' ')
        end
        row < rows && println(io)
    end
end

# module Calendars
