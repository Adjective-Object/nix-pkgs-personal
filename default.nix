# default to a local build
{localProjectsRoot ? null}:
let 
  pkgs = import <nixpkgs> {};
  quick-install = import ./lib/quick-install.nix {
    inherit localProjectsRoot pkgs;
  };
in with quick-install; with pkgs;
# list of projects that have been packaged so far
{
  
  #####################
  # PERSONAL PROJECTS #
  #####################

  # websites
  blog = loadPackage websites/blog.nix "blog";
  personal-site = loadPackage websites/personal-site.nix "personal-site";

  # xgcm environment tools
  
  xgcm = loadPackage xgcm-pipeline/xgcm.nix "xgcm";
  mizu = loadHsPackage xgcm-pipeline/mizu.nix "mizu";
  prism = loadHsPackage xgcm-pipeline/prism.nix "prism";

  ###########################
  # PERSONAL CONFIGURATIONS #
  ###########################

  # vim
  vim = callPackage ./my-env/vim.nix {};
  vim-osx = callPackage ./my-env/vim.nix {
    name = "vim-osx";
    osx=true;
  };

  # zsh
  zsh = callPackage ./my-env/zsh.nix {
    antigen-hs-bridge = ./lib/antigen-hs-bridge.nix;
  };

}

