{ mkDerivation, base, bytestring, canonical-filepath, colour
, JuicyPixels, kmeans, MissingH, prizm, stdenv, fetchFromGitHub
}:
mkDerivation {
  pname = "prism";
  version = "0.1.0.0";
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "prism";
    rev = "6090efc81c95c9192cc93e7e01448cf4133a7040";
    sha256 = "0pvyskzkzy2z1l6hhkd4s7kn0qh31waa56zarirmfrxd2vab9v75";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring canonical-filepath colour JuicyPixels kmeans
    MissingH prizm
  ];
  homepage = "https://github.com/Adjective-Object/prism";
  description = "A simple command line tool for generating colour palettes from images";
  license = stdenv.lib.licenses.asl20;
}
