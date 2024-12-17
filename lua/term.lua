local M = {}

local aucmd = vim.api.nvim_create_autocmd
local augrp = vim.api.nvim_create_augroup

local term_buf = nil
local term_win = nil

local function openTerm()
  if vim.fn.bufexists(term_buf) ~= 1 then
    aucmd('TermOpen', {
      group = augrp('custom-term-open', { clear = true }),
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
      end,
    })
    aucmd('TermEnter', {
      group = augrp('custom-term', { clear = true }),
      callback = function()
        for _, bufs in ipairs(vim.fn.getbufinfo(term_buf)) do
          aucmd({ 'BufWriteCmd', 'FileWriteCmd', 'FileAppendCmd' }, {
            group = augrp('custom-term-close', { clear = true }),
            buffer = bufs.bufnr,
            command = 'q!',
          })
        end
      end,
    })
    vim.cmd([[split | wincmd J | resize 15 | term]])
    term_win = vim.fn.win_getid()
    term_buf = vim.fn.bufnr('%')
    vim.api.nvim_buf_set_name(term_buf, 'TERMINAL')
  elseif vim.fn.win_gotoid(term_win) ~= 1 then
    vim.cmd('sbuffer ' .. term_buf .. '| wincmd J | resize 15')
    term_win = vim.fn.win_getid()
  end
  vim.cmd([[startinsert]])
end

local function hideTerm()
  if vim.fn.win_gotoid(term_win) == 1 then
    vim.cmd([[hide]])
  end
end

M.term_toggle = function()
  if vim.fn.win_gotoid(term_win) == 1 then
    hideTerm()
  else
    openTerm()
  end
end

return M
