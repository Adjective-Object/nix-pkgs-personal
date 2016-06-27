{stdenv, haskellPackages, fetchFromGitHub, git,
 myAntigenBundle, 
 extra-zshrc ? null,
 name ? "zsh-custom"}:
let
  antigen-hs = fetchFromGitHub {
    owner="Tarrasch";
    repo="antigen-hs";
    rev="b1300db52ab2d46d74220daafd041535d7644113";
    sha256 = "0rzrdric7adq9lcv3cfhsnqli8dfl1bzagn5clsz68i2gbyvh9d8";
  };

  buildHaskellEnv =
    haskellPackages.ghcWithPackages
      (hsPackages: with hsPackages; [
          # libraries
          text
          directory
          filepath
          process

          cabal-install
      ]);

in stdenv.mkDerivation {
  inherit name;

  meta = {
    description = "tool to build zsh plugin bundles using antigen-hs";
    homepage = "https://github.com/Tarrasch/antigen-hs";
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.Adjective-Object ];
  };

  src=antigen-hs;
  
  buildInputs = [ buildHaskellEnv git ];

  phases = [ "configurePhase" "buildPhase" "installPhase" ];

  configurePhase = ''
    # set build locations in antigen-hs
    export ANTIGEN_HS_MY="${myAntigenBundle}";
    export ANTIGEN_HS_OUT="$out";
    export ANTIGEN_HS_HOME="${antigen-hs}";

    # locate ssl certs for using git in the build shell
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export SSL_CERT_FIL=/etc/ssl/certs/ca-certificates.crt

    # package invokes cabal-install itself so we export HOME as /tmp 
    # to avoid the /homeless-shelter issue
    export HOME="/tmp";
  '';

  buildPhase = ''
    # build the source package
    runghc -i"$ANTIGEN_HS_HOME" -- ${myAntigenBundle};

  '';

  installPhase = 
  let executable = "$out/bin/${name}"; 
      bundlerc = "$out/.zshrc";
  in ''
    # make bin
    mkdir -p $(dirname ${executable});

    # create a zsh wrapper that sources the bundle before sourcing typical rcs
    echo "#!/bin/sh" > ${executable}
    echo "export ZDOTDIR=$out" >> ${executable}
    echo "zsh" >> ${executable}

    chmod +x ${executable}

    # create a custom zshrc to exec the bundle
    echo "source $out/antigen-hs.zsh" > ${bundlerc}
  '' +
  (if ! builtins.isNull extra-zshrc 
    then ''
      cat ${extra-zshrc} >> ${bundlerc}
    ''
    else ""
  ) +
  ''
    echo '[[ -a "$HOME/.zshrc" ]] && source $HOME/.zshrc' >> ${bundlerc}
  '';

}

