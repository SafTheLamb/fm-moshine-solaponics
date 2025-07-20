local ftech = require("__fdsl__.lib.technology")

if not data.raw.technology["moshine-tech-glass"] or data.raw.technology["moshine-tech-glass"].hidden then
	ftech.remove_prereq("moshine-solaponics", "moshine-tech-glass")
end
