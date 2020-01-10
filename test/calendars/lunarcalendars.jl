module test_calendars_lunarcalendars

using Test
using Calendars.LunarCalendars

april23 = Date(2020, 4, 23)
lunar_april23 = Lunar(april23)
@test lunar_april23 == Lunar(2020, 4, 1, false)
@test lunar_to_solar(lunar_april23) == april23

# intercalation
may23 = Date(2020, 5, 23)
lunar_may23 = Lunar(may23)
@test lunar_may23 == Lunar(2020, 4, 1, true)
@test lunar_to_solar(lunar_may23) == may23

solar = Date(2020, 1, 9)
lunar = Lunar(solar)
@test solar_to_lunar(solar) == lunar == Lunar(2019, 12, 15, false)
@test lunar_to_solar(lunar) == Date(lunar) == solar

end # module test_calendars_lunarcalendars
