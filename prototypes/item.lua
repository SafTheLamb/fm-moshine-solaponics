local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
  {
    type = "item",
    name = "shielded-glass",
    icon = "__moshine-solaponics__/graphics/icons/shielded-glass.png",
    subgroup = "moshine-processes",
    order = "ffg",
    stack_size = 50,
    weight = 5 * kg,
    random_tint_color = {0.85, 1, 0.85, 0.85}
  },
  {
    type = "item",
    name = "thermal-garden",
    icon = "__moshine-solaponics__/graphics/icons/thermal-garden.png",
    subgroup = "agriculture",
    order = "az[thermal-garden]",
    place_result = "thermal-garden",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    stack_size = 10,
    weight = 100 * kg
  }
})
