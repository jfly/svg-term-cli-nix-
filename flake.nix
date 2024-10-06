{
  description = "svg-term-cli, packaged as a nix flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    src = {
      url = "github:marionebl/svg-term-cli";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ src, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem = { pkgs, ... }: {
        packages.default = pkgs.callPackage ./default.nix { inherit src; };
      };
    };
}
