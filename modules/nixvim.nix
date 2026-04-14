{config, lib, pkgs, inputs, ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      harpoon.enable = true;
      lualine.enable = true;
      gitsigns.enable = true;
      todo-comments.enable = true;
      indent-blankline.enable = true;
      comment.enable = true;
      undotree.enable = true;
      luasnip.enable = true;
      oil.enable = true;
      fugitive.enable = true;
      web-devicons.enable = true;
      autoclose.enable = true;



      cmp = {
        enable = true;
	autoEnableSources = true;
	settings = {
	  snippet.expand = "luasnip";
	  sources = [
	    { name = "nvim_lsp"; }
	    { name = "path"; }
	    { name = "buffer"; }
	    { name = "luasnip"; }
	  ];
	  mapping = {
	    "<C-Space>" = "cmp.mapping.complete()";
	    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
	    "<C-e>" = "cmp.mapping.close()";
	    "<C-f>" = "cmp.mapping.scroll_docs(4)";
	    "<C-y>" = "cmp.mapping.confirm({ select = true })";
	    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	  };
	};
      };
      lsp = {
        enable = true;
	#inlayHints.enable = true;
	servers = {
	  #nil_ls.enable = true; # maybe change to nixd in future
	  nixd = {
	    enable = true;
	    settings = {
	      nixos = {
	        autoArchive = true;
	      };
	    };
	  };
	  pyright.enable = true;
	  zls.enable = true;
	};
	keymaps = {
	  #silent = true;
	  lspBuf = {
	    gd = {
	      action = "definition";
	      desc = "Goto Definition";
	    };
	    gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Code Action";
            };
            "<C-k>" = {
              action = "signature_help";
              desc = "Signature Help";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
	  };
	};
      };

      molten = {
        enable = true;
	#lazyLoad.enable = true;

	# Configuration settings for molten.nvim. More examples at https://github.com/nix-community/nixvim/blob/main/plugins/by-name/molten/default.nix#L191
	settings = {
	  auto_image_popup = false;
	  auto_init_behavior = "init";
	  auto_open_html_in_browser = false;
	  auto_open_output = true;
	  cover_empty_lines = false;
	  copy_output = false;
	  enter_output_behavior = "open_then_enter";
	  image_location = "both";
	  image_provider = "image.nvim";
	  #open_cmd
	  output_crop_border = true;
	  output_show_exec_time = true;
	  output_show_more = false;
	  output_virt_lines = false;
	  output_win_border = [ "" "━" "" "" ];
	  output_win_cover_gutter = true;
	  output_win_hide_on_leave = true;
	  output_win_max_height = 15;
	  output_win_max_width = 80;
	  output_win_style = false;
	  save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
	  tick_rate = 500;
	  use_border_highlights = false;
	  limit_output_chars = 10000;
	  virt_lines_off_by_1 = false;
	  virt_text_output = false;
	  #virt_text_max_lines
	  wrap_output = false;
	  output_win_zindex = 50;
	  #virt_text_truncate
	  #floating_window_focus = "top";
	};
      };
    };
    keymaps = [
    ];
  };
}
