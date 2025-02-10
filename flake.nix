{
  description = "A flake to download, extract, and install qobuz-player";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = {
        qobuz-player = pkgs.stdenv.mkDerivation {
          name = "qobuz-player";
          src = pkgs.fetchurl {
            url = "https://github.com/sofusa/qobuz-player/releases/download/v0.2.4.1/qobuz-player-x86_64-unknown-linux-gnu.tar.gz";
            sha256 = "sha256-wP7x9dNVwu2PHoAeXo58kXQ3bHCwu2Z9+O5zTa0/8Fk=";
          };

          unpackPhase = ''
            tar xf $src
          '';

          installPhase = ''
            install -m755 -D qobuz-player $out/bin/qobuz-player
          '';
        };
      };
    }
  );
}
