return {
  'seblj/roslyn.nvim',
  ft = 'cs',
  opts = {
    config = {
      settings = {
        ['csharp|inlay_hints'] = {
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    },
  },
  enabled = true,
}
