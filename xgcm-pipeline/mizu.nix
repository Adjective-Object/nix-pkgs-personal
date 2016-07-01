{ mkDerivation, aeson, base, bytestring, canonical-filepath
, containers, filepath, MissingH, split, stdenv, fetchFromGitHub
}:
mkDerivation {
  pname = "mizu";
  version = "0.1.0.0";
  src = fetchFromGitHub {
    owner = "Adjective-Object";
    repo = "mizu";
    rev = "0f18cde97e80178d217c39dcfdb0f71363410023";
    sha256 = "0vz7xlwflnapx9z214r4hyigi2wamgh34vrl1zd9fp14smxip70g";
  };

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base bytestring canonical-filepath containers filepath
    MissingH split
  ];
  description = "create templates from files by matching them to colours";
  license = stdenv.lib.licenses.asl20;
}
