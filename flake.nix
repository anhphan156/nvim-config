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
        overlays = [
          inputs.neovim-nightly.overlays.default
          (import ./overlays/gdb.nix)
        ];
      };
      inherit (pkgs) lib callPackage;
    in {
      default = pkgs.callPackage ./neovim.nix {
        initLua = ./config/init.lua;
        myConfig = ./config/myConfig;
        snippets = ./config/snippets;
        scripts = ./scripts 
          |> builtins.readDir 
          |> lib.filterAttrs (_: v: v == "regular") 
          |> lib.mapAttrsToList (k: _: callPackage "${self}/scripts/${k}" {});
      };
    });

    overlays = forAllSystems (system: final: prev: {
      neovim = self.packages.${system}.default;
    });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
}
