return {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  opts = function(_, opts)
    local status = require "astroui.status"
    local heirline = require "heirline"
    local lib = require "heirline-components.all"
    opts.statusline[1] = status.component.mode { mode_text = { padding = { left = 1, right = 1 } } } -- add the mode text
    opts.statusline[#opts.statusline] = nil -- remove mode indicator at the end

    opts.tabline = { -- UI upper bar
      lib.component.tabline_buffers(),
      lib.component.fill { hl = { bg = "tabline_bg" } },
      lib.component.tabline_tabpages(),
    }

    opts.winbar = nil

    lib.init.subscribe_to_events()
    heirline.load_colors(lib.hl.get_colors())
    heirline.setup(opts)

    return opts
  end,
}
