# 🧶 Personal Nix Flake Templates

[![Nix Flake Check](https://github.com/milchinskiy/nix-templates/actions/workflows/flake-check.yml/badge.svg)](https://github.com/milchinskiy/nix-templates/actions/workflows/flake-check.yml)

This repository contains a collection of reusable Nix flake templates for
various types of projects. Each template is minimal, idiomatic, and leverages
`nixpkgs` to provide clean developer environments
and reproducible builds.

---

## 📦 Available Templates

| Template             | Description                                                           |
|----------------------|-----------------------------------------------------------------------|
| `trivial`            | 🧪 A trivial flake template — ideal for testing, experimentation, or learning how flakes work.         |
| `rust-base`          | 🦀 Base flake template for a Rust project. Includes `rustc`, `cargo`, and a minimal build setup. |
| `typescript`         | 📘 Base flake template for a TypeScript project. Provides `nodejs` and `tsc` via `nixpkgs`.           |
| `go-base`            | 🐹 Base flake template for a Go project. Provides `go` and `gopls` via `nixpkgs`.                  |
| `clang`              | 🚀 Base flake template for a C/C++ project. Provides `clang`, `cmake` and `clang-tools` via `nixpkgs`. |

---

## 🚀 Usage

You can use these templates directly with [`nix flake init`](https://nixos.wiki/wiki/Flakes#Using_a_flake_template):

```bash
# Create a new project using one of the templates
nix flake init -t github:milchinskiy/nix-templates#<template-name>
```
