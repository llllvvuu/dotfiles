return function()
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
    })

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      -- border = "single",
      silent = true,
    })

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = true,
    })

  --- @param command lsp.Command
  --- @param ctx lsp.HandlerContext
  vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
    --- @type (lsp.Location|lsp.LocationLink)[]
    local locations = command.arguments[3]
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client and locations and #locations > 0 then
      local items =
        vim.lsp.util.locations_to_items(locations, client.offset_encoding)
      vim.fn.setloclist(
        0,
        {},
        " ",
        { title = "References", items = items, context = ctx }
      )
      vim.api.nvim_command("lopen")
    end
  end

  local aucmds = {}
  local augroup = vim.api.nvim_create_augroup("lsp_augroup", { clear = false })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if
        client
        and client.server_capabilities.codeLensProvider
        and not aucmds[args.buf]
      then
        aucmds[args.buf] = vim.api.nvim_create_autocmd(
          { "CursorHold", "CursorHoldI" },
          {
            group = augroup,
            callback = vim.lsp.codelens.refresh,
            buffer = args.buf,
          }
        )
      end
    end,
  })
end
