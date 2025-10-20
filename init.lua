-- suppress ONLY the lspconfig deprecation warning
local _notify = vim.notify
vim.notify = function(msg, level, opts)
	if
		type(msg) == "string"
		and msg:find("The `require%('lspconfig'%)`")
		and msg:find("deprecated, use vim%.lsp%.config")
	then
		return
	end
	return _notify(msg, level, opts)
end

require("config.lazy")
