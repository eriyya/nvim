local M = {}

M.set_keymaps = function(mappings)
    for mode, maps in pairs(mappings) do
        for _, map in pairs(maps) do
            local opts = map[3] or { noremap = true }

            if #mode > 1 then
                local modes = {}
                for i = 1, #mode do
                    table.insert(modes, mode:sub(i, i))
                end
                mode = modes
            end

            vim.keymap.set(mode, map[1], map[2], opts)
        end
    end
end

M.map = function(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

return M
