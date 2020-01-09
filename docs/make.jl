using Documenter
using Calendars
using .Calendars.Times
using .Calendars.LunarCalendars

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [Calendars,
               Calendars.Times,
               Calendars.LunarCalendars,
              ],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/custom.css"],
    ),
    sitename = "Calendars.jl 🗓",
    authors = "WooKyoung Noh",
    pages = Any[
        "Home" => "index.md",
        "VerticalCalendar" => "VerticalCalendar.md",
        "HorizontalCalendar" => "HorizontalCalendar.md",
        "Times" => "Times.md",
        "LunarCalendars" => "LunarCalendars.md",
    ],
)
