data:extend({
	{
		type = "corpse",
		name = "thermal-garden-remnants",
		icon = "__moshine-solaponics__/graphics/icons/thermal-garden.png",
		icon_size = 64, icon_mipmaps = 4,
		flags = {"placeable-neutral", "not-on-map"},
		hidden_in_factoriopedia = true,
		subgroup = "production-machine-remnants",
		order = "a-g-a",
		selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
		tile_width = 3,
		tile_height = 3,
		selectable_in_game = false,
		time_before_removed = 60 * 60 * 15, -- 15 minutes
		final_render_layer = "remnants",
		remove_on_tile_placement = false,
		animation = util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-remnants",{
			scale = 0.875,
			frame_count = 1,
			direction_count = 1,
		}),
	}
})
