# gitsmith.nvim

Neovim plugin for [gitsmith](https://github.com/suraj16thjan/gitsmith) — a fast terminal UI for GitLab and GitHub.

Opens gitsmith in a floating terminal window inside Neovim.

## Requirements

- Neovim >= 0.9
- [gitsmith](https://github.com/suraj16thjan/gitsmith) installed and on your `$PATH`
- `glab` and/or `gh` authenticated

## Installation

### lazy.nvim

```lua
{
  "suraj16thjan/gitsmith.nvim",
  cmd = { "Gitsmith", "GitsmithToggle" },
  keys = {
    { "<leader>gm", "<cmd>GitsmithToggle<cr>", desc = "Toggle gitsmith" },
  },
  opts = {},
}
```

### packer.nvim

```lua
use {
  "suraj16thjan/gitsmith.nvim",
  config = function()
    require("gitsmith").setup()
  end,
}
```

## Configuration

```lua
require("gitsmith").setup({
  cmd = "gitsmith",    -- path to the gitsmith binary
  width = 0.85,        -- fraction of editor width (or absolute columns)
  height = 0.85,       -- fraction of editor height (or absolute rows)
  border = "rounded",  -- border style: "none", "single", "double", "rounded", "solid", "shadow"
  title = " gitsmith ",
  title_pos = "center",
})
```

## Usage

| Command           | Description                                     |
| ----------------- | ----------------------------------------------- |
| `:Gitsmith`       | Open gitsmith (focuses existing window if open) |
| `:GitsmithToggle` | Toggle gitsmith window visibility               |

### Lua API

```lua
require("gitsmith").open()
require("gitsmith").toggle()
```

## License

[MIT](LICENSE)
