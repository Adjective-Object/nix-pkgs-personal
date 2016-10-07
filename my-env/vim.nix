{stdenv, vim_configurable, vimPlugins, name ? "vim"}:
vim_configurable.customize {
  inherit name;
  # add custom .vimrc lines like this:
  vimrcConfig.customRC = builtins.readFile ./vimrc;
  vimrcConfig.vam.knownPlugins = vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [

    # load always
    { name = "ctrlp-vim"; }
    { name = "fugitive"; }
    { name = "Gist"; }
    { name = "Tagbar"; }
    { name = "The_NERD_tree"; }
    { name = "UltiSnips"; }
    { name = "vim-addon-nix"; }
    { name = "vim-airline"; }
    { name = "vim-airline-themes"; }
    { name = "vim-buffergator"; }
    { name = "vim-coffee-script"; }
    { name = "vim-easy-align"; }
    { name = "vim-gitgutter"; }
    { name = "vim-indent-guides"; }
    { name = "vim-multiple-cursors"; }
    { name = "vim-polyglot"; }
    { name = "vim-snippets"; }

    # example of how to open a package only on certain filenames
    # { name = "phpCompletion"; filename_regex = "^.php\$"; }

  ] ++ 

  # some packages do not build on osx, so we only add them if we are
  # not on osx 
  (if ! stdenv.isDarwin then [
      { name = "youcompleteme"; } # llvm build broken on osx
  ] else []);
}
