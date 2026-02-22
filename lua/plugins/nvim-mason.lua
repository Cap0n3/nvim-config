-- Mason plugin 
-- Mason is a package manager for Neovim that installs and manages external tools
-- such as LSP servers, formatters, linters, and debug adapters.

return {
    -- Main Mason plugin
    "mason-org/mason.nvim",

    -- Plugin options
    opts = {
        ui = {
            icons = {
                package_installed = "✓",   -- Icon for installed packages
                package_pending = "➜",     -- Icon for packages currently installing
                package_uninstalled = "✗", -- Icon for packages not installed
            }
        }
    },
}

