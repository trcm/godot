let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  inherit (builtins) concatStringsSep mapAttrsToList;
  pin = builtins.fromJSON (builtins.readFile ./nixpin.json);

  nixpin = fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (pin) rev sha256;
  };
  pkgs = import nixpin {};
in
pkgs.mkShell {
  nativeBuildInputs = [ pkgs.mono pkgs.pkg-config ];
  buildInputs = (with pkgs; [
    scons xorg.libX11 xorg.libXcursor xorg.libXinerama xorg.libXrandr xorg.libXrender
    xorg.libXi xorg.libXext xorg.libXfixes freetype openssl alsaLib libpulseaudio
    libGLU zlib yasm mono pkg-config dotnetPackages.Nuget msbuild
  ]);
}
