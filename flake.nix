{
  description = "A collection of my personal flake templates";

  outputs = { ... }: {
    templates = {
      rust-base = {
        path = ./templates/rust-base;
        description = "A base flake template for a rust project";
      };
      trivial = {
        path = ./templates/trivial;
        description = "A trivial flake template";
      };
      typescript = {
        path = ./templates/typescript;
        description = "Base flake template for a typescript project";
      };
      vite-vue-typescript = {
        path = ./templates/vite-vue-typescript;
        description = "Base Vite + Vue + TypeScript flake using flake-utils";
      };
      go-base = {
        path = ./templates/go-base;
        description = "Minimal Go project using flake-utils";
      };
    };
  };
}
