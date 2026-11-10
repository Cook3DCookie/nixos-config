{
  pkgs,
  config,
  osConfig,
  ...
}:

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
      lspconfig.enable = true;

      markview = {
        enable = true;
        settings = {
          latex = {
            enable = true;
            blocks = {
              enable = true;
              hl = "MarkviewCode";
              pad_char = " ";
              pad_amount = 3;
              text = "LaTeX";
              text_hl = "MarkviewCodeInfo";
            };
            inlines.enable = true;
            subscripts.fake_preview = false;
          };
        };
      };

      # TODO: either remove or make it work for maths
      render-markdown = {
        enable = false;
        settings = {
          latex = {
            enabled = true;
            converter = [ "utftex" ];
            inline = true;
            block = true;
            position = "center";
            highlight = "RenderMarkdownMath";
          };
        };
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = false;
        folding.enable = false; # TODO: change to launch unfolded
      };

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
            "<C-o>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          formatters_by_ft = {
            python = [
              "ruff_fix"
              "ruff_format"
              "ruff_organize_imports"
            ];
            nix = [ "nixfmt" ];
            zig = [ "zigfmt" ];
          };
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 500;
          };
        };
      };
    };

    lsp = {
      inlayHints.enable = true;
      servers = {
        nixd = {
          enable = true;
          config = {
            nixd =
              let
                flakePath = "${config.home.homeDirectory}/nix-config";
                hostname = osConfig.networking.hostName;

                systemAttribute = if pkgs.stdenv.isDarwin then "darwinConfigurations" else "nixosConfigurations";

              in
              {
                options = {
                  system.expr = ''
                    		    (builtins.getFlake "${flakePath}").${systemAttribute}.${hostname}.options
                    		  '';
                  home-manager.expr = ''
                    		    (builtins.getFlake "${flakePath}").${systemAttribute}.${hostname}.options.home-manager.users.type.getSubOptions []
                    		  '';
                };
              };
          };
        };
        pyright.enable = true;
        zls.enable = true;
        omnisharp = {
          enable = true;
          config.on_attach = pkgs.lib.generators.mkLuaInline ''
            	    function(client, bufnr)
            	      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            	    end
            	  '';
        };

      };
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gr";
          lspBufAction = "references";
        }
        {
          key = "gD";
          lspBufAction = "declaration";
        }
        {
          key = "gI";
          lspBufAction = "implementation";
        }
        {
          key = "gT";
          lspBufAction = "type_definition";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>cw";
          lspBufAction = "workspace_symbol";
        }
        {
          key = "<leader>cr";
          lspBufAction = "rename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
        {
          key = "<C-k>";
          lspBufAction = "signature_help";
        }
        {
          key = "<leader>cd";
          action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        }
        {
          key = "]d";
          action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
        }
        {
          key = "[d";
          action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
        }
      ];
    };

    keymaps = [

    ];

    colorschemes.kanagawa.enable = true;

    extraPackages = with pkgs; [
      tree-sitter
      fd
      dotnetCorePackages.sdk_8_0_1xx
    ];
  };
}
