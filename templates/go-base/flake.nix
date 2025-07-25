{
  description = "Minimal Go project using flake-utils";

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
      # Dev shell with Go
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          gopls
          golangci-lint-langserver
          gofumpt
          goimports-reviser
          golines
        ];
      };

      # Build Go project with `nix build`
      packages.default = pkgs.buildGoModule {
        pname = "go-app";
        version = "0.1.0";

        src = ./.;

        # auto-detect go.mod and go.sum
        vendorSha256 = null;

        # Optional: uncomment if using a main package in a subdirectory
        # subPackages = [ "./cmd/myapp" ];
      };
    });
}
