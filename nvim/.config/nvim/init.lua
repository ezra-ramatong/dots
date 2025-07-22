for _, source in ipairs({
	"core.options",
	"core.keymaps",
	"core.lazy",
	"core.autocommands",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.notify("Failed to load " .. source .. "\n\n" .. fault)
	end
end
