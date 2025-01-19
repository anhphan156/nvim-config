{
  symlinkJoin,
  neovim,
  makeWrapper,
  initLua ? "",
  myConfig,
  vimPlugins,
  runCommandLocal,
  lib,
  ...
}: let
  packageName = "NvimPlugins";

  foldPlugins = builtins.foldl' (acc: x: acc ++ [x] ++ foldPlugins (x.dependencies or [])) [];

  startPlugins = [
    vimPlugins.telescope-nvim
    vimPlugins.nvim-treesitter.withAllGrammars
  ];


  startPluginsWithDeps = lib.unique <| foldPlugins startPlugins;

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
        --set-default NVIM_APPNAME nvim-custom
    '';
  }
