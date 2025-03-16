local job = require('plenary.job')

local M = {}

local function split_args(str)
  local s = {}
  for a in string.gmatch(str, '%S+') do
    table.insert(s, a)
  end
  return s
end

local function has_solution(path)
  local suffix = '.sln'
  local content = vim.split(vim.fn.glob(path .. '/*'), '\n', { trimempty = true })
  for _, item in pairs(content) do
    if item:sub(-#suffix) == suffix then
      return true
    end
  end
  return false
end

local function find_closest_sln(path, depth)
  if depth >= 10 then
    return nil
  end
  if has_solution(path) then
    return path
  end
  local parent = vim.fn.resolve(path .. '/../')
  return find_closest_sln(parent, depth + 1)
end

local function new_project(type, name)
  local cwd = vim.fn.getcwd()
  local sln_dir = find_closest_sln(cwd, 0)

  if sln_dir == nil then
    vim.print('Could not find solution file')
    return
  end

  local proj_dir = vim.fn.resolve(sln_dir .. name)
  vim.print('Creating project: ' .. proj_dir)

  local cmd = job
    ---@diagnostic disable-next-line: missing-fields
    :new({
      command = 'dotnet',
      args = { 'new', type, '--name', name, '--output', proj_dir },
      on_stdout = function(_, data)
        print(data)
      end,
    })

  cmd
    ---@diagnostic disable-next-line: missing-fields
    :and_then_on_success(job:new({
      command = 'dotnet',
      args = { 'sln', 'add', '--in-root', proj_dir },
      on_stdout = function(_, data)
        print(data)
      end,
    }))

  cmd:start()
end

local function type_completion(_, line)
  local args = split_args(line)

  if #args == 1 then
    return { 'sln', 'console', 'classlib', 'web' }
  end

  return {}
end

function M.setup(opts)
  vim.api.nvim_create_user_command('DotnetNew', function(cmd_opts)
    local args = split_args(cmd_opts.args)
    if #args < 2 then
      vim.print('Missing arguments, usage: DotnetNew <type> <name>')
      return
    end
    local type = args[1]
    local name = args[2]
    new_project(type, name)
  end, { complete = type_completion, nargs = '*' })
end

return M
