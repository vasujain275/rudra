{ pkgs, inputs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        gopls
        luajitPackages.lua-lsp
        yaml-language-server
        clang-tools # for clangd
        lua-language-server
        rust-analyzer
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted # for html, cssls, etc.
        nodePackages.svelte-language-server
        nodePackages.graphql-language-service-cli
        nodePackages."@tailwindcss/language-server"
        pyright
        # Linters and formatters
        nodePackages.prettier
        stylua
        python310Packages.isort
        python310Packages.black
        python310Packages.pylint
        nodePackages.eslint
        # Additional tools
        emmet-ls
        nodePackages."@prisma/language-server"
      ];
      plugins = with pkgs.vimPlugins; [

        nvim-cmp 
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugins/autocomplete.lua;
        }
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        cmp-path
        friendly-snippets


        {
          plugin = nvim-autopairs;
          config = toLuaFile ./nvim/plugins/autopairs.lua;
        }

        {
          plugin = rose-pine;
          config = toLuaFile ./nvim/plugins/color-scheme.lua;
        }

        {
          plugin = conform-nvim;
          config = toLuaFile ./nvim/plugins/formatting.lua;
        }

        {
          plugin = gitsigns-nvim;
          config = toLuaFile ./nvim/plugins/git-signs.lua;
        }

        {
          plugin = indent-blankline-nvim;
          config = toLuaFile ./nvim/plugins/indent-line.lua;
        }

        {
          plugin = lazygit-nvim;
          config = toLuaFile ./nvim/plugins/lazygit.lua;
        }

        {
          plugin = nvim-lint;
          config = toLuaFile ./nvim/plugins/linting.lua;
        }


        fidget-nvim
        cmp-nvim-lsp
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugins/lsp.lua;
        }

        {
          plugin = mini-nvim;
          config = toLuaFile ./nvim/plugins/mini-nvim.lua;
        }

        {
          plugin = oil-nvim;
          config = toLuaFile ./nvim/plugins/oil.lua;
        }

        plenary-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        nvim-web-devicons
        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugins/telescope.lua;
        }
        
        {
          plugin = which-key-nvim;
          config = toLuaFile ./nvim/plugins/which-key.lua;
        }

        (nvim-treesitter.withPlugins (plugins: with plugins; [
          tree-sitter-json
          tree-sitter-javascript
          tree-sitter-typescript
          tree-sitter-tsx
          tree-sitter-yaml
          tree-sitter-html
          tree-sitter-css
          tree-sitter-prisma
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-svelte
          tree-sitter-graphql
          tree-sitter-bash
          tree-sitter-lua
          tree-sitter-vim
          tree-sitter-dockerfile
          tree-sitter-gitignore
          tree-sitter-query
          tree-sitter-vimdoc
          tree-sitter-c
        ]))

        vim-sleuth
        comment-nvim
        vim-be-good
        nvim-jdtls
        transparent-nvim
        nvim-treesitter.withAllGrammars
        todo-comments-nvim
        vim-tmux-navigator
      ];
      extraConfig = ''
        set noemoji
        nnoremap : <cmd>FineCmdline<CR>
      '';
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/plugins/treesitter.lua}
      '';
    };
  };
}
