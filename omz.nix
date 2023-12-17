# This script was inspired by the ArchLinux User Repository package:
#
#   https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=oh-my-zsh-git
{ lib, stdenv, bash, zsh }:

stdenv.mkDerivation rec {
  version = "master";
  pname = "omz";

  src = ./.;

  strictDeps = true;
  buildInputs = [ bash lua ];

  installPhase = ''
    runHook preInstall

    outdir=$out/share/omz

    mkdir -p $outdir
    cp -r * $outdir
    cd $outdir

    rm -rf .git*

    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple and customized fork of oh-my-zsh";
    homepage = "https://github.com/imxyy1soope1/omz";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
