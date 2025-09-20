{
  description = "A rust project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        nativeBuildInputs = with pkgs; [
          cargo
          rustc
          rustfmt
          rust-analyzer
          clippy
        ];
        buildInputs = [];
      in {
        devShell = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          packages = with pkgs; [
            gdb
          ];
          shellHook = ''
            echo "Rust toolchain: $(rustc --version)"
            echo "Rust analyzer: $(rust-analyzer --version)"
            echo "Clippy: $(clippy-driver --version)"
          '';
        };

        package = pkgs.stdenv.mkDerivation {
          inherit nativeBuildInputs buildInputs;
          name = manifest.name;
          version = manifest.version;
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
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
