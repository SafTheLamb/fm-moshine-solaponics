if mods["wood-industry"] then
	local huge_rock = data.raw["simple-entity"]["moshine-huge-volcanic-rock"]
	if huge_rock and huge_rock.minable then
		-- rocks just rock!
		local results = huge_rock.minable.results
		if results then
			table.insert(results, {type="item", name="charcoal", amount_min=3, amount_max=5})
		end
	end
end
