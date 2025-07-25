{
  description = "Base Vite + Vue + TypeScript flake using flake-utils";

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
      nodePackages = pkgs.nodePackages;
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs
          nodePackages.typescript
          nodePackages.vite
          pkgs.cacert # required for some package installs over HTTPS
        ];

        shellHook = ''
          echo "🔧 Dev shell ready — use 'npm install' and 'npm run dev'"
        '';
      };

      packages.default = pkgs.stdenv.mkDerivation {
        pname = "vite-vue-ts-app";
        version = "0.1.0";
        src = ./.;

        buildInputs = [pkgs.nodejs];

        buildPhase = ''
          export HOME=$(mktemp -d)
          npm ci
          npm run build
        '';

        installPhase = ''
          mkdir -p $out
          cp -r dist/* $out/
        '';
      };
    });
}
