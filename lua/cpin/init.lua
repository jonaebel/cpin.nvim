local M = {}

function M.setup(opts)
    opts = opts or {}
    print("Hello from cpin!")
end

function M.hello()
    print("cpin plugin is working!")
end

return M
