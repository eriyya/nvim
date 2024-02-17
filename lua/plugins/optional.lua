return {
  -- Additional ocaml things
  {
    'tjdevries/ocaml.nvim',
    priority = 800,
  },
  -- Discord rich presence
  {
    'andweeb/presence.nvim',
    opts = {
      show_time = false,
      enable_line_number = false,
    }
  }
}
