-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {

  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.vue" },

  -- Editing
  { import = "astrocommunity.editing-support.multiple-cursors-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.texpresso-vim" },

  -- Colorschemes
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Motion
  { import = "astrocommunity.motion.mini-surround" },

  -- Completion
  { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.copilot-cmp" },

  -- Bars and Lines
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
}
