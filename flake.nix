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
        overlays = import ./overlays inputs;
      };
    in {
      default = pkgs.callPackage ./neovim.nix {
        initLua = ./config/init.lua;
        myConfig = ./config/myConfig;
        snippets = ./config/snippets;
        cDebugTmux = pkgs.callPackage ./scripts/CDebugTmux.nix {};
      };
    });

    overlays.default = final: prev: {
      neovim = self.packages."x86_64-linux".default;
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
}
