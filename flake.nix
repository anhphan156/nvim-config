{
  description = "nvim flake";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    supportedSystem = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystem;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in {
      default = pkgs.neovim;    
    });

    overlays.default = _: prev': let 
      prev = prev'.extend <| nixpkgs.lib.composeManyExtensions [
        (import ./overlays/gdb.nix)
        (inputs.neovim-nightly.overlays.default)
      ];
    in {
      neovim = prev.callPackage ./neovim.nix {
        initLua = ./config/init.lua;
        myConfig = ./config/myConfig;
        snippets = ./config/snippets;
        scripts = ./scripts 
          |> builtins.readDir 
          |> prev.lib.filterAttrs (_: v: v == "regular") 
          |> prev.lib.mapAttrsToList (k: _: prev.callPackage "${self}/scripts/${k}" {});
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
}
