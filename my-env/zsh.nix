{callPackage, antigen-hs-bridge}:
callPackage antigen-hs-bridge {
  name="zsh-adjective";
  myAntigenBundle=./MyAntigen.hs;
  extra-zshrc=./zshrc;
}
