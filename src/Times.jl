module Times # Calendars

export Day, Hour, Minute, Second, Millisecond, Nanosecond
export DateTime, Date, Time, millisecond2datetime, datetime2millisecond

using Dates
using .Dates: CompoundPeriod

"""
         Times.Day(n::Union{Rational,AbstractFloat})::CompoundPeriod
"""
function Dates.Day(n::Union{Rational,AbstractFloat})::CompoundPeriod
    val = 24 * n
    if 24 == val
        (CompoundPeriod ∘ Day)(1)
    else
        Hour(val)
    end
end

"""
         Times.Hour(n::Union{Rational,AbstractFloat})::CompoundPeriod
"""
function Dates.Hour(n::Union{Rational,AbstractFloat})::CompoundPeriod
    val = 60 * n
    if 60 == val
        (CompoundPeriod ∘ Hour)(1)
    else
        Minute(val)
    end
end

"""
         Times.Minute(n::Union{Rational,AbstractFloat})::CompoundPeriod
"""
function Dates.Minute(n::Union{Rational,AbstractFloat})::CompoundPeriod
    val = 60 * n
    if 60 == val
        (CompoundPeriod ∘ Minute)(1)
    else
        Second(val)
    end
end

"""
         Times.Second(n::Union{Rational,AbstractFloat})::CompoundPeriod
"""
function Dates.Second(n::Union{Rational,AbstractFloat})::CompoundPeriod
    val = 1000 * n
    if 1000 == val
        (CompoundPeriod ∘ Second)(1)
    else
        Millisecond(val)
    end
end

"""
         Times.Millisecond(n::Union{Rational,AbstractFloat})::CompoundPeriod
"""
function Dates.Millisecond(n::Union{Rational,AbstractFloat})::CompoundPeriod
    val = 1000_000 * n
    if 1000_000 == val
        (CompoundPeriod ∘ Millisecond)(1)
    else
        Nanosecond(val)
    end
end

Base.isless(x::Union{Period,Dates.CompoundPeriod}, y::Union{Period,Dates.CompoundPeriod}) = isless(Dates.tons(x), Dates.tons(y))

"""
         millisecond2datetime(millisecond::Int64)::DateTime
"""
function millisecond2datetime(millisecond::Int64)::DateTime
    rata = Dates.UNIXEPOCH + millisecond
    return DateTime(Dates.UTM(rata))
end

"""
         datetime2millisecond(dt::DateTime)::Int64
"""
function datetime2millisecond(dt::DateTime)::Int64
    Dates.value(dt) - Dates.UNIXEPOCH
end

end # module Calendars.Times
