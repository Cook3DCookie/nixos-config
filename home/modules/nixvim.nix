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
	settings = {
	  snippet.expand = "luasnip";
	  sources = [
	    { name = "nvim_lsp"; }
	    { name = "path"; }
	    { name = "buffer"; }
	    { name = "luasnip"; }
	  ];
	};
      };
      lsp = {
        enable = true;
	#inlayHints.enable = true;
	servers = {
	  nil_ls.enable = true; # maybe change to nixd in future
	  pyright.enable = true;
	};
	keymaps = {
	  #silent = true;
	  lspBuf = {
	    gd = {
	      action = "definition";
	      desc = "Goto Definition";
	    };
	  };
	};
      };
    };
    keymaps = [
    ];
  };
}
