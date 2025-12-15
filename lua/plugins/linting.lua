return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    -- Remove markdown from linters_by_ft if it exists
    if opts.linters_by_ft then
      opts.linters_by_ft.markdown = nil
      opts.linters_by_ft.md = nil
    end

    return opts
  end,
}
