{
  description = "A collection of my personal flake templates";

  outputs = {self, ...}: {
    templates = {
      trivial = {
        path = ./templates/trivial;
        description = "A trivial flake template";
      };
      rust = {
        path = ./templates/rust;
        description = "Base flake template for a rust project";
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
