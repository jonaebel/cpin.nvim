-- lua/cpin/cli.lua
-- Single point of contact with the cpin binary.
-- Requires Neovim >= 0.10 (vim.system).

local M = {}

local _config = {
    binary = "cpin",
    global = false,
}

--- Configure the CLI wrapper.
--- @param opts table  { binary?: string, global?: boolean }
function M.setup(opts)
    opts = opts or {}
    if opts.binary ~= nil then _config.binary = opts.binary end
    if opts.global ~= nil then _config.global = opts.global end
end

--- Internal: run the binary asynchronously.
--- @param args    string[]                argv after the binary name
--- @param opts    { global?: boolean }    per-call flag overrides
--- @param callback fun(err: string|nil, stdout: string|nil)
local function run(args, opts, callback)
    local cmd = { _config.binary }
    for _, v in ipairs(args) do
        cmd[#cmd + 1] = v
    end
    if (opts and opts.global ~= nil) and opts.global or
       (not (opts and opts.global ~= nil) and _config.global) then
        cmd[#cmd + 1] = "--global"
    end

    vim.system(cmd, { text = true }, function(result)
        if result.code ~= 0 then
            local msg = (result.stderr ~= "" and result.stderr)
                     or result.stdout
                     or ("cpin exited with code " .. result.code)
            callback(msg, nil)
        else
            callback(nil, result.stdout)
        end
    end)
end

--- Add a note.
--- @param file     string
--- @param line     number|string
--- @param content  string
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.add(file, line, content, opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "add", file .. ":" .. tostring(line), content }, opts, callback)
end

--- List notes for a file, optionally filtered to one line.
--- @param file     string
--- @param line     number|string|nil
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.list(file, line, opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    local args = { "list", file }
    if line ~= nil then args[#args + 1] = tostring(line) end
    run(args, opts, callback)
end

--- List every note in the project (or global store).
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.list_all(opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "list" }, opts, callback)
end

--- Remove the note at file:line.
--- @param file     string
--- @param line     number|string
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.remove(file, line, opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "remove", file .. ":" .. tostring(line) }, opts, callback)
end

--- Search notes by keyword.
--- @param keyword  string
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.search(keyword, opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "search", keyword }, opts, callback)
end

--- Export all notes as JSON, parsed into a list of { file, line, content }.
--- The binary emits: [{"file":"...","line":N,"note":"..."},...]
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, notes: table[]|nil)
function M.export_json(opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "export", "--json" }, opts, function(err, stdout)
        if err then return callback(err, nil) end
        local ok, parsed = pcall(vim.json.decode, stdout)
        if not ok then
            return callback("cpin: failed to parse JSON: " .. tostring(parsed), nil)
        end
        local notes = {}
        for _, entry in ipairs(parsed) do
            notes[#notes + 1] = {
                file    = entry.file,
                line    = entry.line,
                content = entry.note,
            }
        end
        callback(nil, notes)
    end)
end

--- Export all notes as Markdown.
--- @param opts     { global?: boolean }|fun(...)   (optional)
--- @param callback fun(err: string|nil, stdout: string|nil)
function M.export_md(opts, callback)
    if type(opts) == "function" then callback = opts; opts = {} end
    run({ "export", "--md" }, opts, callback)
end

return M
