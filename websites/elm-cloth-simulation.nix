{ stdenv, elmPackages, git, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "elm-cloth-simulation";
  buildInputs = [ elmPackages.elm git ];
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "elm-cloth-simulation";
    rev = "2dcd6f70d2a9184bddf108f9520d480776e17a3c";
    sha256 = "09lkkwgxx21394pix80cqv8f45kvjswk2qz4w8785cg8bfhlk0pj";
  };
  meta = {
    description = "Cloth simulation written in elm";
  };

  # disable other phases (too much stuff)
  phases = [ "configurePhase" "buildPhase" "installPhase" ];

  configurePhase = ''
    # cabal homeless shelter fix
    export HOME=/tmp

    # locate ssl certs for using git in the build shell
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export SSL_CERT_FIL=/etc/ssl/certs/ca-certificates.crt


  '';

  buildPhase = ''
    pwd
    ls
    elm-package install
    elm-make App.elm --yes
  '';

  installPhase = ''
    mkdir $out
    mv index.html $out
  '';

}

