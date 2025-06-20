data:extend({
  {
    type = "fluid",
    name = "chloroplast-extract",
    icon = "__moshine-solaponics__/graphics/icons/fluid/chloroplast-extract.png",
    subgroup = "fluid",
    order = "c[astroponics]-c[chorloplast-extract]",
    default_temperature = 25,
    base_color = {r=0.6, g=0.8, b=0.1}, -- #99b219
    flow_color = {r=0.6, g=0.867, b=0.267}, -- #99dd44
  },
  {
    type = "fluid",
    name = "petroketone-hot",
    icon = "__moshine-solaponics__/graphics/icons/fluid/petroketone-hot.png",
    subgroup = "fluid",
    order = "fga",
    default_temperature = 150,
    heat_capacity = "200J",
    base_color = {0.4, 0.2, 0.30},
    flow_color = {0.7, 0.4, 0.55},
  },
  {
    type = "fluid",
    name = "petroketone-cold",
    icon = "__moshine-solaponics__/graphics/icons/fluid/petroketone-cold.png",
    subgroup = "fluid",
    order = "fgb",
    default_temperature = -15,
    heat_capacity = "200J",
    base_color = {0.0, 0.2, 0.45},
    flow_color = {0.1, 0.4, 0.7},
  },
})
