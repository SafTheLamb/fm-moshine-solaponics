data:extend({
	{
		type = "technology",
		name = "moshine-solaponics",
		icon = "__moshine-solaponics__/graphics/technology/solaponics.png",
    	icon_size = 256,
		effects = {
			{type="unlock-recipe", recipe="shielded-glass"},
			{type="unlock-recipe", recipe="thermal-garden"},
			{type="unlock-recipe", recipe="tree-solaponics"},
			{type="unlock-recipe", recipe="petroketone"},
			{type="unlock-recipe", recipe="petroketone-cooling"}
		},
		prerequisites = {"moshine-tech-silicon-carbide", "moshine-tech-glass", "energy-shield-equipment"},
		unit = {
			count = 500,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 60
		}
	}
})
