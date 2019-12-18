module Times # Calendars

export Day, Hour, Minute, Second, Millisecond

using Dates
using .Dates: CompoundPeriod

"""
         Times.Day(n::Float64)::Union{Period,CompoundPeriod}
"""
function Dates.Day(n::Float64)::Union{Period,CompoundPeriod}
    d = trunc(Int, n)
    h = n - d
    iszero(h) ? Day(d) : Day(d) + Hour(round(Int, 24h))
end

"""
         Times.Hour(n::Float64)::Union{Period,CompoundPeriod}
"""
function Dates.Hour(n::Float64)::Union{Period,CompoundPeriod}
    h = trunc(Int, n)
    m = n - h
    iszero(m) ? Hour(h) : Hour(h) + Minute(round(Int, 60m))
end

"""
         Times.Minute(n::Float64)::Union{Period,CompoundPeriod}
"""
function Dates.Minute(n::Float64)::Union{Period,CompoundPeriod}
    m = trunc(Int, n)
    s = n - m
    iszero(s) ? Minute(m) : Minute(m) + Second(round(Int, 60s))
end

"""
         Times.Second(n::Float64)::Union{Period,CompoundPeriod}
"""
function Dates.Second(n::Float64)::Union{Period,CompoundPeriod}
    s = trunc(Int, n)
    ms = n - s
    iszero(ms) ? Second(s) : Second(s) + Millisecond(round(Int, 1000ms))
end

function Base.isless(a::Union{Period,CompoundPeriod}, b::Union{Period,CompoundPeriod})
    isless(Dates.toms(a), Dates.toms(b))
end

end # module Calendars.Times
