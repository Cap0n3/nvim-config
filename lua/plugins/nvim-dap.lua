return {
	-- Core debug adapter protocol plugin
	"mfussenegger/nvim-dap",

	-- Extra UI for DAP and async helpers
	dependencies = {
		"rcarriga/nvim-dap-ui", -- Graphical panels for breakpoints, scopes, etc.
		"nvim-neotest/nvim-nio", -- Async I/O support (required by dap-ui)
	},

	-- Key mappings for common debug actions
	keys = {
		-- Breakpoints
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<F9>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},

		-- Execution control
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Continue / Launch",
		},

		-- Step actions
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>du",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		-- Terminate
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},

		-- UI toggle
		{
			"<leader>dU",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle DAP UI",
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Initialize DAP UI with default layout
		dapui.setup()

		-- Automatically open UI when debugging starts
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- Automatically close UI when debugging stops
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- GDB adapter definition (how to talk to GDB via DAP)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		-- C++ debug configuration (how to run the program in debugger)
		dap.configurations.cpp = {
			{
				name = "Launch C++", -- Name shown in selection menu
				type = "gdb", -- Matches adapter above
				request = "launch", -- Start a new process
				program = function() -- Ask user for executable path
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}", -- Working directory for program
				stopAtEntry = false, -- Don't break on main()
			},
		}

		-- Reuse same config for C files
		dap.configurations.c = dap.configurations.cpp
	end,
}
