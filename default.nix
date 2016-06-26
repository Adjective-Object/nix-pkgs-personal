# default to a local build
{localProjectsRoot ? null}:
let 
  lib = import ./lib.nix {
    inherit localProjectsRoot;
    pkgs = import <nixpkgs> {};
  };
in with lib;
# list of projects that have been packaged so far
{
  # websites
  blog = loadPackage websites/blog.nix "blog";
  personal-site = loadPackage websites/personal-site.nix "personal-site";

  # xgcm environment tools
  xgcm = loadPackage xgcm-pipeline/xgcm.nix "xgcm";
  mizu = loadHsPackage xgcm-pipeline/mizu.nix "mizu";
  prism = loadHsPackage xgcm-pipeline/prism.nix "prism";
}

