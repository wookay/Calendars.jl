# module Calendars

export HorizontalCalendar

using Dates: Dates

struct HorizontalCalendar
    startDate::Date
    endDate::Date
    datespans::Vector{DateSpan}
    cell::NamedTuple{(:size, :margin)}

    function HorizontalCalendar(startDate::Date,
                              endDate::Date ;
                              datespans::Vector{DateSpan}=DateSpan[],
                              cell::NamedTuple{(:size, :margin)} = (size = (2, 1), margin = (1, 0)))
        new(startDate, endDate, datespans, cell)
    end

    function HorizontalCalendar(d::Date)
        d_today = today()
        HorizontalCalendar(firstdayofmonth(d), lastdayofmonth(d); datespans=[DateSpan([d_today], :cyan)])
    end

    function HorizontalCalendar()
        d = d_today = today()
        HorizontalCalendar(firstdayofmonth(d), lastdayofmonth(d); datespans=[DateSpan([d_today], :cyan)])
    end
end

function Base.show(io::IO, cal::HorizontalCalendar)
    sunday = firstdayofweek(cal.startDate) - Day(1)
    grid = mapfoldl(vcat, collect(sunday:Week(1):cal.endDate), init=Array{Date, 2}(undef, 0, 7)) do sun
        reshape(sun:Day(1):(sun + Day(6)), (1, 7))
    end
    td_dict = Dict{Int,Union{Int,String}}()
    days_of_week_abbr = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    daysofweek = merge(
        Dict(1 => days_of_week_abbr[Dates.Sunday]),
        Dict(map(Dates.Monday:Dates.Saturday) do nth
            (nth+1, days_of_week_abbr[nth])
        end))
    (rows, cols) = size(grid)
    for row in 1:rows
        nth = findfirst(d -> day(d) == 1, grid[row, :])
        if nth !== nothing
            firstday = grid[row, :][nth]
            if cal.startDate <= firstday <= cal.endDate
                m = ENGLISH.months_abbr[month(firstday)]
                td_dict[row] = m
                td_dict[row+1] = year(firstday)
            end
        end
    end
    if isempty(td_dict)
        firstday = cal.startDate
        m = ENGLISH.months_abbr[month(firstday)]
        row = 1
        td_dict[row] = m
        td_dict[row+1] = year(firstday)
    end

    leftside = 4
    print(io, repeat(' ', leftside))
    print(io, ' ')
    print(io, join(map(1:cols) do col
        haskey(daysofweek, col) ? daysofweek[col] : repeat(' ', 2)
    end, ' '))
    println(io)

    prev_year = nothing
    colormap = Dict{Date,Symbol}()
    for span in cal.datespans, date in span.dates
        colormap[date] = span.color
    end
    for row in 1:rows
        leftsidetext = repeat(' ', leftside)
        if haskey(td_dict, row)
            val = td_dict[row]
            if val isa Int && prev_year != val
                leftsidetext = rpad(val, leftside)
                prev_year = val
            elseif val isa String
                leftsidetext = rpad(val, leftside)
            end
        end
        print(io, leftsidetext)
        print(io, ' ')
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
