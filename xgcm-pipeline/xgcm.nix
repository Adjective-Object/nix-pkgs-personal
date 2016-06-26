{ fetchFromGitHub, stdenv, pkgconfig, boost, lua }:
let version = "0.1";
    pkgsha = "65dc20cc1a03d4feba990f830186404c90462d599e5f4b37610d4d822d67aec4";

in stdenv.mkDerivation {
  name = "xgcm-${version}";
  buildInputs = [ lua ];
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "xgcm";
    rev = "c2a14696ae78f02284d144617427ec6bbf400673";
    sha256 = pkgsha;
  };

  meta = {
    description = "templating tool with embedded lua scripting";
    license = stdenv.lib.licenses.asl20;
    # maintainers = [ stdenv.lib.maintainers.Adjective-Object ];
  };

  makeFlags="PREFIX=$(out)";

}

