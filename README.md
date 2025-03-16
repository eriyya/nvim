## Neovim config

## User Settings

A user-settings file is generated on startup if there isn't already one.

_Example `settings.json` file_

```json
{
  "excluded_lsp": [],
  "theme": "catppuccin-mocha",
  "code_llm": false
}
```

## Requirements

Neovim 0.10.x

Install requirements with Chocolatey:  
`choco install -y git ripgrep wget fd unzip gzip mingw make`

### Commands

- `:Themes` - Shows a list of available colorschemes, sets new colorscheme on selection
- `:InstallServers` - Installs servers using Mason from a configured list
- `:NeorgWorkspace` - Swap between Neorg workspaces via a telescope dropdown

## Terminal stuff

Currently using [Wezterm](https://github.com/wez/wezterm)

### Fonts

[Iosevka](https://typeof.net/Iosevka/)

<details>
<summary>My Iosevka Config</summary>

```toml
[buildPlans.IosevkaRvn]
family = "Iosevka Rvn"
spacing = "normal"
serifs = "sans"
noCvSs = true
exportGlyphNames = false

[buildPlans.IosevkaRvn.variants.design]
one = "no-base"
zero = "slashed"
braille-dot = "round"
asterisk = "penta-high"
paren = "flat-arc"
brace = "curly-flat-boundary"
lig-neq = "more-slanted"
lig-equal-chain = "with-notch"
lig-hyphen-chain = "with-notch"
lig-double-arrow-bar = "without-notch"

[buildPlans.IosevkaRvn.weights.Light]
shape = 300
menu = 300
css = 300

[buildPlans.IosevkaRvn.weights.Regular]
shape = 400
menu = 400
css = 400

[buildPlans.IosevkaRvn.weights.Medium]
shape = 500
menu = 500
css = 500

[buildPlans.IosevkaRvn.weights.SemiBold]
shape = 600
menu = 600
css = 600

[buildPlans.IosevkaRvn.weights.Bold]
shape = 700
menu = 700
css = 700

[buildPlans.IosevkaRvn.widths.Normal]
shape = 500
menu = 5
css = "normal"

[buildPlans.IosevkaRvn.widths.Extended]
shape = 600
menu = 7
css = "expanded"

[buildPlans.IosevkaRvn.widths.Condensed]
shape = 416
menu = 3
css = "condensed"

[buildPlans.IosevkaRvn.widths.SemiCondensed]
shape = 456
menu = 4
css = "semi-condensed"

[buildPlans.IosevkaRvn.widths.SemiExtended]
shape = 548
menu = 6
css = "semi-expanded"

```

</details>

