return {
  "yetone/avante.nvim",
  opts = {
    provider = "gemini",
    providers = {
      gemini = {
        model = "gemini-3-flash-preview",
      },
      -- claude = {
      --   endpoint = "https://api.anthropic.com",
      --   model = "claude-sonnet-4-20250514",
      --   timeout = 30000, -- Timeout in milliseconds
      -- },
    },
  },
}
