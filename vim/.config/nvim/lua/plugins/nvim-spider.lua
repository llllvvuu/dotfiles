return {
  {
    "chrisgrieser/nvim-spider",
    keys =  {
       {
         "ge",
         "<cmd>lua require('spider').motion('ge')<CR>",
         desc = "Spider-ge",
         mode = { "n", "o", "x"},
       },
       {
         "<M-w>",
         "<cmd>lua require('spider').motion('w')<CR>",
         desc = "Spider-w",
         mode = { "n", "o", "x"},
       },
       {
         "<M-e>",
         "<cmd>lua require('spider').motion('e')<CR>",
         desc = "Spider-e",
         mode = { "n", "o", "x"},
       },
       {
         "<M-b>",
         "<cmd>lua require('spider').motion('b')<CR>",
         desc = "Spider-b",
         mode = { "n", "o", "x"},
       },
    },
  },
}
