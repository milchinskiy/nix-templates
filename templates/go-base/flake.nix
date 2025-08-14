{
  description = "Base flake template for a go project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    eachSystem = nixpkgs.lib.genAttrs supportedSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        nativeBuildInputs = with pkgs; [
          go
          gopls
          golangci-lint-langserver
          gofumpt
          goimports-reviser
          golines
        ];
        buildInputs = [
        ];
      in {
        devShell = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          packages = [];
          shellHook = ''
            go --version
          '';
        };

        package = pkgs.stdenv.mkDerivation {
          inherit nativeBuildInputs buildInputs;
          name = "go-app";
          src = ./.;
          installPhase = ''
            echo "Installing project"
          '';
          buildPhase = ''
            echo "Building project"
          '';
        };
      }
    );
  in {
    devShells =
      nixpkgs.lib.mapAttrs (system: systemAttrs: {
        default = systemAttrs.devShell;
      })
      eachSystem;

    packages =
      nixpkgs.lib.mapAttrs (system: systemAttrs: {
        default = systemAttrs.package;
      })
      eachSystem;
  };
}
