{vim_configurable, vimPlugins, name ? "vim", osx ? false}:
vim_configurable.customize {
  inherit name;
  # add custom .vimrc lines like this:
  vimrcConfig.customRC = builtins.readFile ./vimrc;
  vimrcConfig.vam.knownPlugins = vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [

    # load always
    { name = "vim-airline"; }
    { name = "vim-airline-themes"; }
    { name = "The_NERD_tree"; }
    { name = "vim-coffee-script"; }
    { name = "vim-easy-align"; }
    { name = "vim-nix"; }
    { name = "Tagbar"; }
    { name = "vim-addon-nix"; }
    { name = "Gist"; }

    # only load when opening a .php file
    { name = "phpCompletion"; filename_regex = "^.php\$"; }

  ] ++ 

  # some packages do not build on osx, so we only add them if we are
  # not on osx 
  (if ! osx then [
      { name = "youcompleteme"; } # llvm build broken on osx
  ] else []);
}
