# from https://github.com/NixOS/nixpkgs/pull/202665#issuecomment-1569980782
# Using odin overlay until the nixpkgs build uses llvm 17
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      odin-overlay = self: super: {
        odin = super.odin.overrideAttrs (old: rec {
          version = "dev-2024-02";
          src = super.fetchFromGitHub {
            owner = "odin-lang";
            repo = "Odin";
            rev = "${version}";
            sha256 = "sha256-v9A0+kgREXALhnvFYWtE0+H4L7CYnyje+d2W5+/ZvHA=";
          };

          nativeBuildInputs = with super; [ makeWrapper which ];

          LLVM_CONFIG = "${super.llvmPackages_17.llvm.dev}/bin/llvm-config";
          postPatch = ''
            sed -i 's/^GIT_SHA=.*$/GIT_SHA=/' build_odin.sh
            sed -i 's/LLVM-C/LLVM/' build_odin.sh
            patchShebangs build_odin.sh
          '';

          installPhase = old.installPhase + "cp -r vendor $out/bin/vendor";
        });
      };

      ols-overlay = self: super: {
        ols = super.ols.overrideAttrs (old: rec {
          version = "nightly-2024-02-17-e7d20e6";
          src = super.fetchFromGitHub {
            owner = "DanielGavin";
            repo = "ols";
            rev = "e7d20e6a6e5e1b10e1860f508579ca2d4b9a0ab0";
            sha256 = "sha256-3QiE2mjynzRT62nY4TxTwQgp2M6yPMi2Wy48L+VPO6k=";
          };

          installPhase = old.installPhase;
        });
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (odin-overlay) (ols-overlay)
        ];
      };

      lib = pkgs.lib;
      in {
        devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
        pkgs.odin
        pkgs.ols
        ];
      };
    });
}
