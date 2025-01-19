require('lz.n').load {
  {
    "leetcode.nvim",
    cmd = "Leet",
    after = function()
      require('leetcode').setup {
        arg = "leetcode.nvim",
        lang = "cpp",
      }
    end
  }
}
