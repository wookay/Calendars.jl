# module Calendars

function getfirstweekdayoffset(monday::Date, firstweekday::Int)::Int
    (firstweekday - 1 - 7) % 7
end

function Base.show(io::IO, cal::VerticalCalendar)
    monday = firstdayofweek(cal.startDate)
    firstweekdayoffset = getfirstweekdayoffset(monday, cal.firstweekday)
    thedayfirstweekday = monday + Day(firstweekdayoffset)
    if cal.startDate - thedayfirstweekday >= Week(1)
        thedayfirstweekday += Week(1)
    end
    grid = mapfoldl(hcat, thedayfirstweekday:Week(1):cal.endDate, init=Array{Date, 2}(undef, 7, 0)) do weekday
        weekday:Day(1):(weekday + Day(6))
    end
    (rows, cols) = size(grid)
    th_years = []
    th_months = []
    dayabbrs = circshift(dayabbr.(Dates.Mon:Dates.Sun; locale=cal.locale), -firstweekdayoffset)
    daysofweek = Dict(map([2, 4, 6]) do nth
        (nth, dayabbrs[nth])
    end)
    for col in 1:cols
        nth = findfirst(d -> day(d) == 1, grid[:, col])
        if nth !== nothing
            firstday = grid[:, col][nth]
            if cal.startDate <= firstday <= cal.endDate
                m = monthabbr(month(firstday), locale=cal.locale)
                push!(th_years, (col, year(firstday)))
                push!(th_months, (col, m))
            end
        end
    end
    if isempty(th_months)
        firstday = cal.startDate
        m = monthabbr(month(firstday), locale=cal.locale)
        push!(th_years, (1, year(firstday)))
        push!(th_months, (1, m))
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
    for (idx, (col, m)) in enumerate(th_months)
        n = cellwidth * (col - prev_col - 1) - diff
        print(io, repeat(' ', n))
        monthtext = string(m, repeat(' ', clamp(cellwidth - (textwidth(m)), 0, cellwidth)))
        print(io, monthtext)
        prev_col = col
    end
    println(io)

    colormap = Dict{Date,Union{Int,Symbol}}()
    for span in cal.datespans, date in span.dates
        colormap[date] = span.color
    end
    for row in 1:rows
        if haskey(daysofweek, row)
            val = daysofweek[row]
            leftsidetext = string(val, repeat(' ', leftside - (textwidth(val))))
            print(io, leftsidetext)
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
