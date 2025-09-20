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
      rust = {
        path = ./templates/rust;
        description = "A flake template for a rust project";
      };
      typescript = {
        path = ./templates/typescript;
        description = "Base flake template for a typescript project";
      };
      go-base = {
        path = ./templates/go-base;
        description = "Base flake template for a go project";
      };
      clang = {
        path = ./templates/clang;
        description = "Base flake template for a clang project";
      };

      default = self.templates.trivial;
    };
  };
}
