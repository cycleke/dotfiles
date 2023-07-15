local ok, distant = pcall(require, "distant")
if not ok then
	return
end

distant.setup({
	["*"] = require("distant.settings").chip_default(),
})
