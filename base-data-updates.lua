local frep = require("__fdsl__.lib.recipe")

-------------------------------------------------------------------------- Shielded glass

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	frep.replace_ingredient("ai-trainer", "glass", "shielded-glass")
	frep.replace_ingredient("3d-data-storage", "glass", "shielded-glass")
end

-------------------------------------------------------------------------- Data processor

if settings.startup["moshine-solaponics-modify-vanilla"].value then

	local data_processor = data.raw["assembling-machine"]["data-processor"]
	for _,fluid_box in pairs(data_processor.fluid_boxes) do
		if fluid_box.production_type == "input" then
			log("MOSHINE_DATA_PROCESSOR_CHANGES")
			for i=#fluid_box.pipe_connections,1,-1 do
				local connection = fluid_box.pipe_connections[i]
				if connection.direction == defines.direction.east or connection.direction == defines.direction.west then
					log(serpent.block(connection))
					table.remove(fluid_box.pipe_connections, i)
				end
			end
			log(serpent.block(fluid_box))
		end
	end
	table.insert(data_processor.fluid_boxes, {
		production_type = "input",
		pipe_picture = assembler3pipepictures(),
		pipe_covers = pipecoverspictures(),
		volume = 1000,
		pipe_connections = {{flow_direction="input", direction=defines.direction.west, position={-1, 0}}},
		secondary_draw_orders = {north=-1},
	})
	table.insert(data_processor.fluid_boxes, {
		production_type = "output",
		pipe_picture = assembler3pipepictures(),
		pipe_covers = pipecoverspictures(),
		volume = 1000,
		pipe_connections = {{flow_direction="output", direction=defines.direction.east, position={1, 0}}},
		secondary_draw_orders = {north=-1},
	})
end

-------------------------------------------------------------------------- Datacells

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	local _,data_ingredient = frep.get_ingredient("datacell-add-raw-data", "raw-data")
	local _,data_result = frep.get_result("datacell-remove-raw-data", "raw-data")
	data_ingredient.fluidbox_index = 1
	data_result.fluidbox_index = 1

	frep.add_ingredient("datacell-add-equation", {type="fluid", name="raw-data", amount=100, fluidbox_index=1})
	frep.add_ingredient("datacell-add-equation", {type="fluid", name="chloroplast-extract", amount=400, fluidbox_index=2, ignored_by_stats=40})
	frep.add_result("datacell-add-equation", {type="fluid", name="bioslurry", amount=40, fluidbox_index=2})
end

-------------------------------------------------------------------------- Model creation

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	local _,model_ingredient = frep.get_ingredient("model-unstable", "raw-data")
	model_ingredient.fluidbox_index = 1

	frep.add_ingredient("model-unstable", {type="fluid", name="chloroplast-extract", amount=100, ignored_by_stats=10, fluidbox_index=2})
	frep.add_result("model-unstable", {type="fluid", name="bioslurry", amount=10, fluidbox_index=2})
	data.raw.recipe["model-unstable"].main_product = "model-unstable"

	frep.add_ingredient("model-stable", {type="fluid", name="petroketone-cold", amount=1000, ignored_by_stats=500})
	frep.add_result("model-stable", {type="fluid", name="petroketone-hot", amount=500, temperature=150, ignored_by_stats=500, ignored_by_productivity=500, fluidbox_index=2})
	data.raw.recipe["model-stable"].main_product = "model-stable"
end

-------------------------------------------------------------------------- Model training

frep.add_ingredient("ai-tier-0", {type="fluid", name="chloroplast-extract", amount=20})
frep.add_ingredient("ai-tier-1", {type="fluid", name="chloroplast-extract", amount=40})
frep.add_ingredient("ai-tier-2", {type="fluid", name="chloroplast-extract", amount=90})
frep.add_ingredient("ai-tier-3", {type="fluid", name="chloroplast-extract", amount=160})
frep.add_ingredient("ai-tier-4", {type="fluid", name="chloroplast-extract", amount=250})
frep.add_ingredient("ai-tier-5", {type="fluid", name="chloroplast-extract", amount=360})
frep.add_ingredient("ai-tier-6", {type="fluid", name="chloroplast-extract", amount=490})
frep.add_ingredient("ai-tier-7", {type="fluid", name="chloroplast-extract", amount=640})
frep.add_ingredient("ai-tier-8", {type="fluid", name="chloroplast-extract", amount=810})
frep.add_ingredient("ai-tier-9", {type="fluid", name="chloroplast-extract", amount=1000})

local ai_trainer = data.raw["furnace"]["ai-trainer"]
-- ai_trainer.source_inventory_size = ai_trainer.source_inventory_size + 1
assert(ai_trainer.fluid_boxes == nil, "Wooden Moshine: Solaponics was about to override the AI Trainer's fluid boxes")
ai_trainer.fluid_boxes = {
	{
		production_type = "input",
		pipe_picture = assembler3pipepictures(),
		pipe_covers = pipecoverspictures(),
		volume = 1000,
		pipe_connections = {{flow_direction="input", direction=defines.direction.north, position={0, -3}}}
	}
}
