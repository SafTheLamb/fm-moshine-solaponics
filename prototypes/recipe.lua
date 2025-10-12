local wood_amount = mods["early-agriculture"] and settings.startup["early-agriculture-buff-tree-plant"].value and 20 or 8
local glass_item = mods["Krastorio2-spaced-out"] and "kr-glass" or "glass"

data:extend({
	{
		type = "recipe",
		name = "shielded-glass",
		category = mods["alloy-smelting"] and "kiln-smelting" or "crafting",
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = mods["alloy-smelting"] and 6.4 or 4,
		ingredients = {
			{type="item", name=glass_item, amount=2},
			{type="item", name="plastic-bar", amount=1},
			{type="item", name="silicon-carbide", amount=1}
		},
		results = {{type="item", name="shielded-glass", amount=1}}
	},
	{
		type = "recipe",
		name = "thermal-garden",
		enabled = false,
		energy_required = 60,
		ingredients = {
			{type="item", name="space-garden", amount=1},
			{type="item", name="shielded-glass", amount=80},
			{type="item", name="heat-pipe", amount=10}
		},
		weight = 2000*kg,
		results = {{type="item", name="thermal-garden", amount=1}}
	},
	{
		type = "recipe",
		name = "petroketone",
		category = "chemistry-or-cryogenics",
		subgroup = "moshine-processes",
		order = "fga",
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = 5,
		ingredients = {
			{type="fluid", name="petroleum-gas", amount=50},
			{type="fluid", name="water", amount=50},
			{type="item", name="silicon", amount=1}
		},
		results = {{type="fluid", name="petroketone-hot", amount=50, temperature=150}}
	},
	{
		type = "recipe",
		name = "petroketone-cooling",
		localised_name = {"recipe-name.petroketone-cooling"},
		icon = "__moshine-solaponics__/graphics/icons/fluid/petroketone-cooling.png",
		category = "chemistry-or-cryogenics",
		subgroup = "moshine-processes",
		order = "fgb",
		enabled = false,
		show_amount_in_title = false,
		allow_productivity = false,
		auto_recycle = false,
		energy_required = 2,
		ingredients = {
			{type="fluid", name="petroketone-hot", amount=100, ignored_by_stats=100},
			{type="fluid", name="water", amount=6}
		},
		results = {
			{type="fluid", name="petroketone-cold", amount=100, temperature=-15, ignored_by_stats=100, ignored_by_productivity=100},
			{type="fluid", name="steam", amount=60, temperature=500}
		},
		main_product = "petroketone-cold"
	},
	{
		type = "recipe",
		name = "tree-solaponics",
		localised_name = {"recipe-name.tree-solaponics"},
		icons = {
			{icon="__base__/graphics/icons/wood.png"},
			{icon="__astroponics__/graphics/icons/fluid/liquid-fertilizer.png", shift={-10,-10}, scale=0.25},
			{icon="__Moshine__/graphics/icons/moshine.png", shift={8,8}, scale=0.3},
		},
		category = "solaponics",
		subgroup = "astroponic-processes",
		order = "m[moshine]-a[solaponics]",
		enabled = false,
		auto_recycle = false,
		allow_productivity = true,
		allow_decomposition = false,
		energy_required = 6,
		ingredients = {
			{type="fluid", name="liquid-fertilizer", amount=50},
			{type="fluid", name="petroketone-cold", amount=100, ignored_by_stats=100},
			{type="item", name="tree-seed", amount=1}
		},
		results = {
			{type="item", name="wood", amount=wood_amount},
			{type="fluid", name="bioslurry", amount=25},
			{type="fluid", name="petroketone-hot", amount=100, temperature=150, ignored_by_stats=100, ignored_by_productivity=100}
		},
		main_product = "wood"
	}
})
if settings.startup["moshine-solaponics-modify-vanilla"].value then
	data:extend({
		{
			type = "recipe",
			name = "chloroplast-extraction",
			localised_name = {"recipe-name.chloroplast-extraction"},
			icon = "__moshine-solaponics__/graphics/icons/fluid/chloroplast-extraction.png",
			category = "electromagnetics",
			subgroup = "astroponic-processes",
			order = "m[moshine]-c[chloroplast-extraction]",
			enabled = false,
			allow_productivity = true,
			allow_quality = false,
			energy_required = 60,
			ingredients = {
				{type="fluid", name="bioslurry", amount=100},
				{type="fluid", name="sulfuric-acid", amount=100},
				{type="item", name="magnet", amount=1, ignored_by_stats=1}
			},
			results = {
				{type="fluid", name="chloroplast-extract", amount=100},
				{type="item", name="magnet", amount=1, probability=0.98, ignored_by_stats=1, ignored_by_productivity=1}
			},
			main_product = "chloroplast-extract"
		},
	})
end
