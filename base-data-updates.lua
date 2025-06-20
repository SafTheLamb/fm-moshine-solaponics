local frep = require("__fdsl__.lib.recipe")

-------------------------------------------------------------------------- Data processor

frep.add_ingredient("model-stable", {type="fluid", name="petroketone-cold", amount=1000, ignored_by_stats=1000})
frep.add_result("model-stable", {type="fluid", name="petroketone-hot", amount=500, temperature=150, ignored_by_stats=500, ignored_by_productivity=500})
data.raw.recipe["model-stable"].main_product = "model-stable"

local data_processor = data.raw["assembling-machine"]["data-processor"]
for _,fluid_box in pairs(data_processor.fluid_boxes) do
	local is_data_connection = true
	for _,connection in pairs(fluid_box.pipe_connections) do
		if connection.flow_direction == "input" then
			if connection.direction == defines.direction.east then
				fluid_box.production_type = "output"
				connection.flow_direction = "output"
				is_data_connection = false
				break
			elseif connection.direction == defines.direction.west then
				is_data_connection = false
			end
		end
	end
	if is_data_connection then
		fluid_box.filter = "raw-data"
	else
		fluid_box.pipe_picture = assembler3pipepictures()
		fluid_box.pipe_covers = pipecoverspictures()
	end
end

frep.add_ingredient("datacell-add-equation", {type="fluid", name="chloroplast-extract", amount=1960})

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
