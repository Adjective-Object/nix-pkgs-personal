{ fetchFromGitHub, stdenv, pkgconfig, lua, cmake }:
let version = "0.1";

in stdenv.mkDerivation {
  name = "xgcm-${version}";
  buildInputs = [ lua cmake stdenv pkgconfig ];
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "xgcm";
    rev = "377c16437e541bf964f9e7a259d47bd47743e938";
    sha256 = "15v5sbfn5d7dkga3rlm8h4xaimqi194cd912n217acq14yk1kwx1";
  };

  meta = {
    description = "templating tool with embedded lua scripting";
    license = stdenv.lib.licenses.asl20;
    # maintainers = [ stdenv.lib.maintainers.Adjective-Object ];
  };

  makeFlags="PREFIX=$(out)";

  installPhase = ''
    mkdir -p $out/bin
    mv xgcm $out/bin/xgcm
  '';

}

