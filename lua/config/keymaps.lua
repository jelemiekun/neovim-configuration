-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-A-Up>", "<cmd>resize +1<CR>")
vim.keymap.set("n", "<C-A-Down>", "<cmd>resize -1<CR>")
vim.keymap.set("n", "<leader>cn", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Cellular Automaton" })

-- Magma Keymaps
vim.keymap.set("n", "<leader>mi", "<cmd>MagmaInit<CR>", { desc = "Initialize a runtime" })
vim.keymap.set("n", "<leader>md", "<cmd>MagmaDeinit<CR>", { desc = "Deinitialize the current runtime" })
vim.keymap.set("n", "<leader>ml", "<cmd>MagmaEvaluateLine<CR>", { desc = "Evaluate the current line" })
vim.keymap.set("x", "<leader>mv", ":<C-u>MagmaEvaluateVisual<CR>", {
  desc = "Evaluate selected text",
})
vim.keymap.set("n", "<leader>mo", function()
  return vim.api.nvim_exec2("MagmaEvaluateOperator", { output = true }).output
end, {
  expr = true,
  desc = "Evaluate with motion",
})
--[[ Disabled due to low chance of usability
vim.keymap.set(
  "n",
  "<leader>ma",
  "<cmd>MagmaEvaluateArgument<CR>",
  { desc = "Evaluate the text following this command" }
)
]]
vim.keymap.set("n", "<leader>mR", "<cmd>MagmaReevaluateCell<CR>", { desc = "Reevaluate the currently selected cell" })
vim.keymap.set(
  "n",
  "<leader>mD",
  "<cmd>MagmaDelete<CR>",
  { desc = "Delete the currently selected cell (do nothing if empty)" }
)
vim.keymap.set("n", "<leader>mO", "<cmd>MagmaShowOutput<CR>", { desc = "Open the output window of active cell" })
vim.keymap.set("n", "<leader>mI", "<cmd>MagmaInterrupt<CR>", { desc = "Interrupts the currently running cell" })
vim.keymap.set("n", "<leader>mr", "<cmd>MagmaRestart<CR>", { desc = "Shuts down and restarts the current kernel." })
vim.keymap.set(
  "n",
  "<leader>ms",
  "<cmd>MagmaSave<CR>",
  { desc = "Save the current cells and evaluated outputs into a JSON file" }
)
vim.keymap.set(
  "n",
  "<leader>mL",
  "<cmd>MagmaLoad<CR>",
  { desc = "Load the cells and evaluated outputs stored in a given JSON file" }
)
vim.keymap.set(
  "n",
  "<leader>me",
  "<cmd>MagmaEnterOutput<CR>",
  { desc = "Enter the output window, if it is currently open." }
)
