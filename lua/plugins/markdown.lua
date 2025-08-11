-- Live preview markdown docs in the browser
return {
  lazy = true,
  cmd = 'MarkdownPreview',
  ft = { 'markdown', 'norg' },
  'iamcco/markdown-preview.nvim',
  build = 'cd app && yarn install',
}
