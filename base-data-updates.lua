local frep = require("__fdsl__.lib.recipe")

-------------------------------------------------------------------------- Shielded glass

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	frep.replace_ingredient("ai-trainer", "glass", "shielded-glass")
	frep.replace_ingredient("3d-data-storage", "glass", "shielded-glass")
end

-------------------------------------------------------------------------- Data processor

local new_input_fluidbox_index = 0
local new_output_fluidbox_index = 0

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	local data_processor = data.raw["assembling-machine"]["data-processor"]

	if data_processor.fluid_boxes then
		for i=#data_processor.fluid_boxes,1,-1 do
			local fluid_box = data_processor.fluid_boxes[i]
			if fluid_box.production_type == "output" then
				for i=#fluid_box.pipe_connections,1,-1 do
					local connection = fluid_box.pipe_connections[i]
					if connection.direction == defines.direction.east or connection.direction == defines.direction.west then
						table.remove(fluid_box.pipe_connections, i)
					end
				end
				if #fluid_box.pipe_connections == 0 then
					table.remove(data_processor.fluid_boxes, i)
				end
			end
		end

		-- Look, this code is pretty fragile if the data processor prototype changes...
		--   and making it flexible would just not be worth it. Have mercy, snouz
		assert(#data_processor.fluid_boxes == 3)
		assert(data_processor.fluid_boxes[1].production_type ~= "output")
		assert(data_processor.fluid_boxes[2].production_type ~= "output")
		assert(data_processor.fluid_boxes[3].production_type == "output")

		-- Important for cosmic-data-outsignal-creation
		for _,connection in pairs(data_processor.fluid_boxes[1].pipe_connections) do
			connection.flow_direction = "input-output"
		end

		table.insert(data_processor.fluid_boxes, {
			production_type = "input",
			pipe_picture = require("__base__.prototypes.entity.assembler-pictures").assembler3pipepictures,
			pipe_covers = pipecoverspictures(),
			volume = 1000,
			pipe_connections = {
				{flow_direction="input", direction=defines.direction.west, position={-1, -1}},
				{flow_direction="input", direction=defines.direction.west, position={-1, 1}}
			},
			secondary_draw_orders = {north=-100, south=100}
		})
		assert(#data_processor.fluid_boxes == 4)
		table.insert(data_processor.fluid_boxes, {
			production_type = "output",
			pipe_picture = require("__base__.prototypes.entity.assembler-pictures").assembler3pipepictures,
			pipe_covers = pipecoverspictures(),
			volume = 1000,
			pipe_connections = {
				{flow_direction="output", direction=defines.direction.east, position={1, -1}},
				{flow_direction="output", direction=defines.direction.east, position={1, 1}}
			},
			secondary_draw_orders = {north=-100, south=100}
		})
		assert(#data_processor.fluid_boxes == 5)
	end
end

-------------------------------------------------------------------------- Datacells

for _,recipe in pairs(data.raw.recipe) do
	if frep.has_category(recipe, "data-processing") then
		local fluid_input_count = 0
		for _,ingredient in pairs(recipe.ingredients or {}) do
			if ingredient.type == "fluid" then
				fluid_input_count = fluid_input_count + 1
				ingredient.fluidbox_index = fluid_input_count
			end
		end
		assert(fluid_input_count < 3)
		for _,result in pairs(recipe.results or {}) do
			if result.type == "fluid" then
				result.fluidbox_index = 1
			end
		end
	end
end

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	frep.add_ingredient("datacell-equation", {type="fluid", name="chloroplast-extract", amount=50, ignored_by_stats=20, fluidbox_index=3})
	frep.add_result("datacell-equation", {type="fluid", name="bioslurry", amount=20, fluidbox_index=2})
end

-------------------------------------------------------------------------- Model creation

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	frep.add_ingredient("model-unstable", {type="fluid", name="chloroplast-extract", amount=50, ignored_by_stats=20, fluidbox_index=3})
	frep.add_result("model-unstable", {type="fluid", name="bioslurry", amount=20, fluidbox_index=2})
	data.raw.recipe["model-unstable"].main_product = "model-unstable"

	frep.add_ingredient("model-stable", {type="fluid", name="petroketone-cold", amount=1000, ignored_by_stats=500, fluidbox_index=3})
	frep.add_result("model-stable", {type="fluid", name="petroketone-hot", amount=500, temperature=150, ignored_by_stats=500, ignored_by_productivity=500, fluidbox_index=2})
	data.raw.recipe["model-stable"].main_product = "model-stable"
end

-------------------------------------------------------------------------- Model training

if settings.startup["moshine-solaponics-modify-vanilla"].value then
	frep.add_ingredient("ai-tier-0", {type="fluid", name="chloroplast-extract", amount=10})
	frep.add_ingredient("ai-tier-1", {type="fluid", name="chloroplast-extract", amount=20})
	frep.add_ingredient("ai-tier-2", {type="fluid", name="chloroplast-extract", amount=30})
	frep.add_ingredient("ai-tier-3", {type="fluid", name="chloroplast-extract", amount=40})
	frep.add_ingredient("ai-tier-4", {type="fluid", name="chloroplast-extract", amount=50})
	frep.add_ingredient("ai-tier-5", {type="fluid", name="chloroplast-extract", amount=60})
	frep.add_ingredient("ai-tier-6", {type="fluid", name="chloroplast-extract", amount=80})
	frep.add_ingredient("ai-tier-7", {type="fluid", name="chloroplast-extract", amount=100})
	frep.add_ingredient("ai-tier-8", {type="fluid", name="chloroplast-extract", amount=120})
	frep.add_ingredient("ai-tier-9", {type="fluid", name="chloroplast-extract", amount=150})

	local ai_trainer = data.raw["furnace"]["ai-trainer"]
	-- ai_trainer.source_inventory_size = ai_trainer.source_inventory_size + 1
	assert(ai_trainer.fluid_boxes == nil, "Wooden Moshine: Solaponics was about to override the AI Trainer's fluid boxes")
	ai_trainer.fluid_boxes = {
		{
			production_type = "input",
			pipe_picture = require("__base__.prototypes.entity.assembler-pictures").assembler3pipepictures,
			pipe_covers = pipecoverspictures(),
			volume = 1000,
			pipe_connections = {{flow_direction="input", direction=defines.direction.north, position={0, -3}}}
		}
	}
end
