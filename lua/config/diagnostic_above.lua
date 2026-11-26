-- Diagnostic handler that renders each diagnostic as a virtual line ABOVE the
-- affected line (Neovim's built-in `virtual_lines` only draws below).
-- Enable with: vim.diagnostic.config({ virtual_lines_above = true })

local severity_hl = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
  [vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
}

local namespaces = {}
local function get_ns(diag_ns)
  if not namespaces[diag_ns] then
    namespaces[diag_ns] = vim.api.nvim_create_namespace("diagnostic_above_" .. diag_ns)
  end
  return namespaces[diag_ns]
end

vim.diagnostic.handlers.virtual_lines_above = {
  show = function(namespace, bufnr, diagnostics, _)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end
    local ns = get_ns(namespace)
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

    -- group diagnostics per line, keeping severity order (severity_sort)
    local by_line = {}
    for _, d in ipairs(diagnostics) do
      by_line[d.lnum] = by_line[d.lnum] or {}
      table.insert(by_line[d.lnum], d)
    end

    local line_count = vim.api.nvim_buf_line_count(bufnr)
    for lnum, diags in pairs(by_line) do
      if lnum < line_count then
        local text = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
        local virt_lines = {}
        for _, d in ipairs(diags) do
          -- align the message with the column where the problem starts
          local pad = string.rep(" ", vim.fn.strdisplaywidth(text:sub(1, d.col)))
          local hl = severity_hl[d.severity] or "DiagnosticVirtualTextError"
          for i, msg in ipairs(vim.split(d.message, "\n", { trimempty = true })) do
            local prefix = i == 1 and "▼ " or "  "
            table.insert(virt_lines, { { pad .. prefix .. msg, hl } })
          end
        end
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
          virt_lines = virt_lines,
          virt_lines_above = true,
        })
      end
    end
  end,
  hide = function(namespace, bufnr)
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, get_ns(namespace), 0, -1)
    end
  end,
}
