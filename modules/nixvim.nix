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
      markview.enable = true;
      render-markdown.enable = false;

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
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          nixd = {
            enable = true;
            settings = {
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
          roslyn_ls.enable = true;
        };
        keymaps = {
          silent = false;
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
            "]d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "[d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
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

    keymaps = [

    ];

    extraPackages = with pkgs; [
      tree-sitter
      fd
    ];
  };
}
