{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    fenix,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        fenix-pkgs = fenix.packages.${system};
        toolchain = fenix-pkgs.complete.toolchain;
      in {
        packages.default = pkgs.callPackage ./. {};

        devShells.default = pkgs.mkShell {
          packages = [
            toolchain
            fenix-pkgs.rust-analyzer
          ];
        };
      }
    );
}
