return {
  "olexsmir/gopher.nvim",
  ft = "go",
  config = function()
    -- Add generate interface implementation
    vim.keymap.set("n", "<leader>gi", function()
      vim.ui.input({ prompt = "Receiver and Interface (e.g., MyStruct io.Reader): " }, function(input)
        if input then
          vim.cmd("GoImpl " .. input)
        end
      end)
    end, { desc = "Go Generate Interface Implementation" })


    -- Add tags with json omitempty
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.keymap.set("n", "<leader>gt", function()
          vim.ui.input({ prompt = "Struct and TagType (e.g., MyStruct json): " }, function(input)
            if not input or input == "" then return end

            local parts = vim.split(input, "%s+")
            local struct_name = parts[1]
            local tag_type = parts[2] or "json" -- default to json if tag type not given

            if not struct_name or struct_name == "" then
              vim.notify("Struct name is required", vim.log.levels.ERROR)
              return
            end

            local file = vim.api.nvim_buf_get_name(0)
            local cmd

            if tag_type == "json" then
              cmd = string.format(
                "gomodifytags -file %s -struct %s -add-tags %s -add-options %s=omitempty",
                vim.fn.shellescape(file), struct_name, tag_type, tag_type
              )
            else
              cmd = string.format(
                "gomodifytags -file %s -struct %s -add-tags %s",
                vim.fn.shellescape(file), struct_name, tag_type
              )
            end

            vim.fn.jobstart(cmd, {
              stdout_buffered = true,
              on_stdout = function(_, data)
                if data then
                  vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
                end
              end,
              on_stderr = function(_, err)
                if err then
                  vim.notify(table.concat(err, "\n"), vim.log.levels.ERROR)
                end
              end,
            })
          end)
        end, { buffer = true, desc = "Add tags to Go struct (Struct TagType)" })
      end,
    })
  end
}
