{
  description = "A trivial flake template";

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
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        # buildInputs = with pkgs; [];
      };

      packages.default = pkgs.stdenv.mkDerivation {
        name = "trivial-project";
        src = ./.;
        buildPhase = "true";
        installPhase = ''
          mkdir -p $out
          echo "Hello from base flake" > $out/README.txt
        '';
      };
    });
}
