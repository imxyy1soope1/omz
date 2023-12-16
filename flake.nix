{
  description = "OMZ flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    let
      overlay =
        final: prev: {
          omz = prev.omz.overrideAttrs (oldAttrs: {
            version = "master";
            src = ./.;
          });
        };
    in
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        {
          packages.omz = pkgs.omz;
          packages.default = pkgs.omz;
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [ zsh ];
          };
        }
      )
    // { overlays.default = overlay; };
}