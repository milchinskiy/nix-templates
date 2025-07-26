{
  description = "A basic rust project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        rustLibSrc = pkgs.rustPlatform.rustLibSrc;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            rustc
            rustfmt
            rust-analyzer
            clippy
          ];

          RUST_SRC_PATH = rustLibSrc;

          shellHook = ''
            echo "Rust toolchain: $(rustc --version)"
            echo "Rust analyzer: $(rust-analyzer --version)"
            echo "Clippy: $(clippy-driver --version)"
          '';
        };

        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "my-rust-project";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };
      }
    );
}
