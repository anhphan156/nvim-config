{
  symlinkJoin,
  neovim,
  makeWrapper,
  lua-language-server,
  nixd,
  alejandra,
  git,
  llvmPackages_19,
  initLua,
  myConfig,
  snippets,
  vimPlugins,
  runCommandLocal,
  lib,
  ...
}: let
  packageName = "NvimPlugins";

  foldPlugins = builtins.foldl' (acc: x: acc ++ [x] ++ foldPlugins (x.dependencies or [])) [];

  startPlugins = with vimPlugins; [
    bufferline-nvim
    lualine-nvim
    snacks-nvim
    nvim-web-devicons
    nvim-notify
    noice-nvim

    nvim-tree-lua
    telescope-nvim
    nvim-treesitter.withAllGrammars
    gitsigns-nvim
    presence-nvim
    vim-fugitive

    tokyonight-nvim

    nvim-lspconfig
    lsp-format-nvim
    lspkind-nvim
    lspsaga-nvim

    nvim-cmp
    cmp-nvim-lsp
    cmp-path
    cmp-buffer
    cmp_luasnip
    luasnip

    mini-nvim
    mini-pairs
  ];

  startPluginsWithDeps = lib.unique <| foldPlugins startPlugins;

  otherDeps = lib.makeBinPath [ 
    lua-language-server 
    nixd 
    alejandra 
    git
    llvmPackages_19.clang-tools
  ];

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${myConfig} $out/pack/${packageName}/start/myConfig
    ${lib.concatMapStringsSep "\n" (x: "ln -vsfT ${x} $out/pack/${packageName}/start/${lib.getName x}") startPluginsWithDeps}
  '';
in
  symlinkJoin {
    name = "nvim";
    paths = [neovim];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags '-u' \
        --add-flags '${initLua}' \
        --add-flags '--cmd' \
        --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
        --set-default NVIM_APPNAME nvim-custom \
        --set PATH ${otherDeps}:$PATH \
        --set SNIPPETS ${snippets}
    '';
  }
