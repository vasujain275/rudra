# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example repository https://github.com/BirdeeHub/nixCats-nvim

# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.

# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    nixCats.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixCats, ... }@inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    extra_pkg_config = {
      # allowUnfree = true;
    };
    inherit (forEachSystem (system: let
      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)
      ];
    in { inherit dependencyOverlays; })) dependencyOverlays;
    
    categoryDefinitions = { pkgs, settings, categories, name, ... }@packageDef: {
      propagatedBuildInputs = {
        generalBuildInputs = with pkgs; [
        ];
      };

      lspsAndRuntimeDeps = {
        general = with pkgs; [
          stdenv.cc.cc
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
          nodePackages.prettier
          stylua
          python310Packages.isort
          python310Packages.black
          python310Packages.pylint
          nodePackages.eslint
          emmet-ls
          nodePackages."@prisma/language-server"

        ];
      };

      startupPlugins = {
        customPlugins = with pkgs.nixCatsBuilds; [ ];
        gitPlugins = with pkgs.neovimPlugins; [ ];
        general = with pkgs.vimPlugins; [ ];
      };

      optionalPlugins = {
        customPlugins = with pkgs.nixCatsBuilds; [ ];
        gitPlugins = with pkgs.neovimPlugins; [ ];
        general = with pkgs.vimPlugins; [ ];
      };

      sharedLibraries = {
        general = with pkgs; [
        ];
      };

      environmentVariables = {
        test = {
          CATTESTVAR = "It worked!";
        };
      };

      extraWrapperArgs = {
        test = [
          '' --set CATTESTVAR2 "It worked again!"''
        ];
      };

      extraPython3Packages = {
        test = (py:[
          py.pylint
          py.pyls-isort
          py.python-lsp-black
        ]);
      };
      extraLuaPackages = {
        test = [ (_:[]) ];
      };
    };

    packageDefinitions = {
      nixCats = {pkgs , ... }: {
        settings = {
          wrapRc = true;
          aliases = [ "vim" ];
        };
        categories = {
          general = true;
          gitPlugins = true;
          customPlugins = true;
          generalBuildInputs = true;
          test = true;
          example = {
            youCan = "add more than just booleans";
            toThisSet = [
              "and the contents of this categories set"
              "will be accessible to your lua with"
              "nixCats('path.to.value')"
              "see :help nixCats"
            ];
          };
        };
      };
    };
    defaultPackageName = "nixCats";
  in
  forEachSystem (system: let
    inherit (utils) baseBuilder;
    customPackager = baseBuilder luaPath {
      inherit nixpkgs system dependencyOverlays extra_pkg_config;
    } categoryDefinitions;
    nixCatsBuilder = customPackager packageDefinitions;
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages = utils.mkPackages nixCatsBuilder packageDefinitions defaultPackageName;

    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ (nixCatsBuilder defaultPackageName) ];
        inputsFrom = [ ];
        shellHook = '''';
      };
    };

    inherit customPackager;
  }) // {
    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = utils.mkNixosModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
    homeModule = utils.mkHomeModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
    inherit utils categoryDefinitions packageDefinitions dependencyOverlays;
    inherit (utils) templates baseBuilder;
    keepLuaBuilder = utils.baseBuilder luaPath;
  };
}
