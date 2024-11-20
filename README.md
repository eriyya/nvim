## Neovim config

...

## User Settings

A user-settings file is generated on startup if there isn't already one.

_Example `settings.json` file_

```json
{
  "excluded_lsp": [],
  "theme": "catppuccin-mocha",
  "code_llm": false,
}
```

## Requirements

Neovim 0.10.x  

Install requirements with Chocolatey:  
```choco install -y git ripgrep wget fd unzip gzip mingw make```

### Commands
- `:Themes` - Shows a list of available colorschemes, sets new colorscheme on selection
- `:InstallFormatters` - Installs a list of pre-configured formatters (`lsp/server_config.lua`:`M.formatters`) 

## Terminal stuff

Currently using [Wezterm](https://github.com/wez/wezterm)

### Fonts

I mainly use these two fonts
[Iosevka](https://typeof.net/Iosevka/) (Term NerdFont)
[Monaspace Neon](https://monaspace.githubnext.com/) (Patched with NerdFont)

