-- Live preview markdown docs in the browser
return {
  lazy = true,
  ft = 'markdown',
  cmd = 'MarkdownPreview',
  'iamcco/markdown-preview.nvim',
  build = 'cd app && yarn install',
}
