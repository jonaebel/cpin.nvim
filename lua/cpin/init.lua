local M = {}

local cli = require("cpin.cli")

--- Setup cpin.
--- @param opts table  { binary?: string, global?: boolean }
function M.setup(opts)
    opts = opts or {}
    cli.setup(opts)
end

M.cli = cli

return M
