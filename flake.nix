{
  description = "A collection of my personal flake templates";

  outputs = {self, ...}: {
    templates = {
      trivial = {
        path = ./templates/trivial;
        description = "A trivial flake template";
      };
      rust-base = {
        path = ./templates/rust-base;
        description = "A base flake template for a rust project";
      };
      typescript = {
        path = ./templates/typescript;
        description = "Base flake template for a typescript project";
      };
      go-base = {
        path = ./templates/go-base;
        description = "Minimal Go project using flake-utils";
      };
      clang = {
        path = ./templates/clang;
        description = "Minimal clang project without external flakes";
      };

      default = self.templates.trivial;
    };
  };
}
