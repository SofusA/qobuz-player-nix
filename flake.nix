{
  description = "A flake to download, extract, and install qobuz-player";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      version = "v0.2.8.2";
    in
    {
      packages = {
        qobuz-player = pkgs.stdenv.mkDerivation {
          name = "qobuz-player";
          src = pkgs.fetchurl {
            url = "https://github.com/sofusa/qobuz-player/releases/download/${version}/qobuz-player-x86_64-unknown-linux-gnu.tar.gz";
            sha256 = "sha256-G5OcWFTqW5igojJe2i7G1iguhNIAxbYp/Jey7g3CMIU=";
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
