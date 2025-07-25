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
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            rustc
            rustfmt
            rust-analyzer
            clippy
          ];

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
