return {
    -- {
    --     'github/copilot.vim',
    --     config = function ()
    --         vim.g.copilot_assume_mapped = true
    --         vim.g.copilot_no_tab_map = true
    --     end
    -- },
    -- {
    --     'hrsh7th/cmp-copilot',
        -- disable = not lvim.builtin.sell_soul_to_devel,
        -- config = function ()
        --     lvim.builtin.cmp.formatting.source_names['copilot'] = '(Cop)'
        --     table.insert(lvim.builtin.cmp.sources, { name = 'copilot' })
        -- end
    -- }
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        dismiss = '<C-l>'
                    }
                }
            })
        end
    },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- }
}
