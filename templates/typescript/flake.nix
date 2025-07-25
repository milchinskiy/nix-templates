{
  description = "Base TypeScript project using flake-utils";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs
          pkgs.nodePackages.typescript # includes `tsc`
        ];
      };

      packages.default = pkgs.stdenv.mkDerivation {
        pname = "ts-app";
        version = "0.1.0";
        src = ./.;

        buildInputs = [
          pkgs.nodejs
          pkgs.nodePackages.typescript
        ];

        buildPhase = ''
          echo "Compiling TypeScript..."
          tsc
        '';

        installPhase = ''
          mkdir -p $out
          cp -r dist/* $out/
        '';
      };
    });
}
