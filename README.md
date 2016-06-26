# nix-pkgs-personal
Package descriptions for my personal projects and environment

## Local sources
In order to simplify development & packageing, allows for package declarations
to be easily overriden for installation from local sources.

The local installation assumed projects are all in the same shared directory
with the same directory names as their package names, e.g.

    /path/to/projects
    ├── blog
    ├── personal-site
    ├── ...
    └── xgcm

To install a package from local sources, install with the the argument 
`localProjectsRoot`

    nix-env -f ./default.nix -i xgcm --argstr localProjectsRoot /path/to/projects


