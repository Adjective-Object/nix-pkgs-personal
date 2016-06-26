{pkgs, localProjectsRoot}:
let 

  # Alias for quick access
  isLocal = !(builtins.isNull localProjectsRoot);
  overrideDerivation = pkgs.stdenv.lib.overrideDerivation;

  # if we are building from local source (development) override the src
  # property of the derivation to point to the folder in the local projects
  # directory with the same name as the package name
  overrideIfLocal = if isLocal
    then (old: pkgName: overrideDerivation old (_ : {
      src = "${localProjectsRoot}/${pkgName}/";
    }))
    else (old: old)
  ;

  # load a package and override it if we are
  # doing a local build
  callAndOverride = (callPackage: pkgPath: localPath:
    overrideIfLocal (callPackage (pkgPath) {}) localPath
  );


in {
  loadPackage = callAndOverride pkgs.callPackage;
  loadHsPackage = callAndOverride pkgs.haskellPackages.callPackage;
}


