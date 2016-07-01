{ stdenv, elmPackages, git, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "elm-cloth-simulation";
  buildInputs = [ elmPackages.elm git ];
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "elm-cloth-simulation";
    rev = "47e476ae436556392c4f02371bc906bdd977cd57";
    sha256 = "0m0a9lylv6fyzc73bwzkza4kdgaz0hsi2qb0s6pql6kfvi8qwrha";
  };
  meta = {
    description = "Cloth simulation written in elm";
  };

  # disable other phases (too much stuff)
  phases = [
    "unpackPhase"
    "configurePhase"
    "buildPhase"
    "installPhase"
  ];

  configurePhase = ''
    # cabal homeless shelter fix
    export HOME=/tmp

    # locate ssl certs for using git in the build shell
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export SSL_CERT_FIL=/etc/ssl/certs/ca-certificates.crt

  '';

  buildPhase = ''
    elm-package install --yes
    elm-make App.elm --yes
  '';

  installPhase = ''
    mkdir $out
    mv index.html $out
  '';

}

