return {
  "CRAG666/code_runner.nvim",
  config = function()
    -- Helper function to avoid repeating logic for C/C++
    local function get_compile_command(compiler, ext)
      return function(...)
        local base = {
          "cd $dir &&",
          compiler .. " $fileName -o",
          "/tmp/$fileNameWithoutExt",
        }
        local exec = {
          "&& /tmp/$fileNameWithoutExt &&",
          "rm /tmp/$fileNameWithoutExt",
        }
        vim.ui.input({ prompt = "Add more args:" }, function(input)
          if input then base[4] = input end -- Handle args
          require("code_runner.commands").run_from_fn(vim.list_extend(base, exec))
        end)
      end
    end

    require("code_runner").setup({
      filetype = {
        c = get_compile_command("gcc"),
        cpp = get_compile_command("g++"),
        go = function(...)
          vim.ui.input({ prompt = "Add more args:" }, function(input)
            local cmd = { "cd $dir &&", "go run $fileName" }
            if input then table.insert(cmd, input) end
            require("code_runner.commands").run_from_fn(cmd)
          end)
        end,
      },
    })
  end,
}
