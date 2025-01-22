{
  symlinkJoin,
  neovim,
  makeWrapper,
  lua-language-server,
  nixd,
  vscode-langservers-extracted,
  glsl_analyzer,
  alejandra,
  git,
  llvmPackages_19,
  openssh,
  wl-clipboard,
  ripgrep,
  curl,
  tmux,
  cDebugTmux,
  imagemagick,
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
    snacks-nvim
    nvim-web-devicons
    nvim-notify
    noice-nvim

    telescope-nvim
    nvim-treesitter.withAllGrammars
    gitsigns-nvim
    presence-nvim
    lz-n
    startup-nvim

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

  optPlugins = with vimPlugins; [
    vim-fugitive
    nvim-tree-lua
    leetcode-nvim
    ollama-nvim
    oil-nvim
    image-nvim
  ];

  startPluginsWithDeps = lib.unique <| foldPlugins startPlugins;
  optPluginsWithDeps = lib.unique <| foldPlugins optPlugins;

  otherDeps = lib.makeBinPath [ 
    lua-language-server 
    nixd 
    vscode-langservers-extracted
    llvmPackages_19.clang-tools
    glsl_analyzer
    alejandra 
    git
    openssh
    wl-clipboard
    ripgrep
    curl
    tmux
    cDebugTmux
    imagemagick
  ];

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${myConfig} $out/pack/${packageName}/start/myConfig
    ${lib.concatMapStringsSep "\n" (x: "ln -vsfT ${x} $out/pack/${packageName}/start/${lib.getName x}") startPluginsWithDeps}
    ${lib.concatMapStringsSep "\n" (x: "ln -vsfT ${x} $out/pack/${packageName}/opt/${lib.getName x}") optPluginsWithDeps}
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
