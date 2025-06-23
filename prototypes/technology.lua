data:extend({
	{
		type = "technology",
		name = "moshine-solaponics",
		icon = "__moshine-solaponics__/graphics/technology/solaponics.png",
    	icon_size = 256,
		effects = {
			{type="unlock-recipe", recipe="shielded-glass"},
			{type="unlock-recipe", recipe="thermal-garden"},
			{type="unlock-recipe", recipe="tree-solaponics"}
		},
		prerequisites = {"moshine-tech-silicon-carbide", "moshine-tech-glass"},
		research_trigger = {
			type = "craft-item",
			item = "silicon-carbide",
			count = 1
		}
	}
})
