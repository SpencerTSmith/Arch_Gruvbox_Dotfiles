return {
	{
		"stevearc/oil.nvim",
		event = "VimEnter",
		opts = {
			delete_to_trash = true,
			default_file_explorer = true,
			watch_for_changes = true,
      skip_confirm_for_simple_edits = false,
			constrain_cursor = "editable",
      cleanup_delay_ms = 200,
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
			columns = {
				"permissions",
				"size",
				"mtime",
				"icon",
			},
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
			view_options = { show_hidden = true, },
			float = { border = "single", },
			preview = { border = "single", },
			confirmation = { border = "single", },
			progress = { border = "single", },
			ssh = { border = "single", },
			keymaps_help = { border = "single", },
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
        ["gx"] = function()
          -- Override the default app for zip files
          local entry = require("oil").get_cursor_entry()
          if not entry then return end

          local path = require("oil").get_current_dir() .. "/" .. entry.name

          if path:match("%.zip$") or path:match("%.7z$") or path:match("%.rar$") then
            vim.cmd("!7z x " .. vim.fn.shellescape(path) .. " -o" .. vim.fn.shellescape(require("oil").get_current_dir()))
          else
            require("oil.actions").open_external.callback()
          end
        end,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Oil: Open parent directory",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local custom_gruvbox = require("lualine.themes.gruvbox")
			custom_gruvbox.normal.a.bg = "#FABD2F"
			local opts = {
				options = {
					theme = custom_gruvbox,
					disabled_filetypes = {
						"dashboard",
					},
					component_separators = "|",
					section_separators = "",
				},
				extensions = { "oil", "nvim-dap-ui", "fugitive", "mason", "neo-tree", "lazy" },
			}
			return opts
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			contrast = "",
			palette_overrides = {},
			overrides = {
				GruvboxRedSign = { bg = "NONE" },
				GruvboxGreenSign = { bg = "NONE" },
				GruvboxYellowSign = { bg = "NONE" },
				GruvboxBlueSign = { bg = "NONE" },
				GruvboxPurpleSign = { bg = "NONE" },
				GruvboxAquaSign = { bg = "NONE" },
				GruvboxOrangeSign = { bg = "NONE" },
      },
			dim_inactive = false,
			transparent_mode = false,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
		  vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
		end,
	},
}
