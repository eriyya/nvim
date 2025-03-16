-- Statusline
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      sections = {
        lualine_c = {
          'filename',
          function()
            if vim.bo.filetype == 'csharp' or vim.bo.filetype == 'cs' then
              local csharp_solution_file = vim.g.roslyn_nvim_selected_solution
              return vim.fs.basename(csharp_solution_file) or ''
            end
            return ''
          end,
        },
        lualine_x = {
          'encoding',
          {
            'fileformat',
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
        },
      },
    })
  end,
}
