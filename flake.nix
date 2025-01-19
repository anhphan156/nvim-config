{
  description = "nvim flake";

  outputs = {nixpkgs, ...} @ inputs: let
    supportedSystem = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystem;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [inputs.neovim-nightly.overlays.default];
      };
    in {
      default = pkgs.callPackage ./neovim.nix {
        initLua = ./config/init.lua;
        myConfig = ./config/myConfig;
      };
    });

    apps.default = inputs.self.packages.default;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
}
