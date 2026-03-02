local ftech = require("__fdsl__.lib.technology")

if not data.raw.technology["moshine-tech-glass"] or data.raw.technology["moshine-tech-glass"].hidden or not data.raw.technology["moshine-tech-glass"].enabled then
	ftech.remove_prereq("moshine-solaponics", "moshine-tech-glass")
end
