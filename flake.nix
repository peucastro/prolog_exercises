{
  description = "A Nix flake for solving Prolog exercises.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            (pkgs.buildFHSEnv {
              name = "sicstus";
              targetPkgs = pkgs: (with pkgs; [
                glibc
              ]);
              runScript = ''
                /usr/bin/env bash
                ${self}/sp-4.10.1-x86_64-linux-glibc2.28/bin/sicstus
              '';
            })
          ];
        };
      }
    );
}
