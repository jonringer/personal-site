{
  description = "jonringer.us flake";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, utils, ... }:
    let
      localOverlay = prev: final: {
        devShell = prev.mkShell {
          nativeBuildInputs = with prev.elmPackages; [
            elm
            elm-review
            elm-test
          ];
        };
      };
      pkgsForSystem = system: import nixpkgs {
        overlays = [ localOverlay ];
        inherit system;
      };

    in utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ] (system: rec {
      legacyPackages = pkgsForSystem system;
      packages = utils.lib.flattenTree {
        inherit (legacyPackages) devShell; # jonringer;
      };
      inherit (legacyPackages) devShell;
      #defaultPackage = packages.jonringer;
      #apps.jonringer = utils.lib.jonringer { drv = packages.jonringer; };  # use as `nix run .#jonringer`
      #hydraJobs = { inherit (legacyPackages) jonringer; };
  }) // {
    # non-system suffixed items should go here
    overlay = localOverlay;
  };
}
