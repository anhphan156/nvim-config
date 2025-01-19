{
  symlinkJoin,
  neovim,
  makeWrapper,
  lua-language-server,
  nixd,
  alejandra,
  git,
  initLua ? "",
  myConfig,
  vimPlugins,
  runCommandLocal,
  lib,
  ...
}: let
  packageName = "NvimPlugins";

  foldPlugins = builtins.foldl' (acc: x: acc ++ [x] ++ foldPlugins (x.dependencies or [])) [];

  startPlugins = with vimPlugins; [
    telescope-nvim
    nvim-treesitter.withAllGrammars
    tokyonight-nvim
    nvim-lspconfig
    lsp-format-nvim
    bufferline-nvim
    lualine-nvim
  ];

  startPluginsWithDeps = lib.unique <| foldPlugins startPlugins;

  otherDeps = lib.makeBinPath [ lua-language-server nixd alejandra git];

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
        --set PATH ${otherDeps}:$PATH
    '';
  }
