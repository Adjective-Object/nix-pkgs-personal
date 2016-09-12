{stdenv, vim_configurable, vimPlugins, name ? "vim"}:
vim_configurable.customize {
  inherit name;
  # add custom .vimrc lines like this:
  vimrcConfig.customRC = builtins.readFile ./vimrc;
  vimrcConfig.vam.knownPlugins = vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [

    # load always
    { name = "Gist"; }
    { name = "Tagbar"; }
    { name = "The_NERD_tree"; }
    { name = "UltiSnips"; }
    { name = "ctrlp-vim"; }
    { name = "vim-addon-nix"; }
    { name = "vim-airline"; }
    { name = "vim-airline-themes"; }
    { name = "vim-buffergator"; }
    { name = "vim-coffee-script"; }
    { name = "vim-easy-align"; }
    { name = "vim-multiple-cursors"; }
    { name = "vim-polyglot"; }
    { name = "vim-snippets"; }
    { name = "fugitive"; }

    # example of how to open a package only on certain filenames
    # { name = "phpCompletion"; filename_regex = "^.php\$"; }

  ] ++ 

  # some packages do not build on osx, so we only add them if we are
  # not on osx 
  (if ! stdenv.isDarwin then [
      { name = "youcompleteme"; } # llvm build broken on osx
  ] else []);
}
