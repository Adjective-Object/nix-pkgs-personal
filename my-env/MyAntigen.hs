{-# LANGUAGE OverloadedStrings #-}
module MyAntigen where

import Antigen (
                -- Rudimentary imports
                AntigenConfig (..)
              , defaultConfig
              , bundle
              , antigen
                -- If you want to source a bit trickier plugins
              , ZshPlugin (..)
              , antigenSourcingStrategy
              , filePathsSourcingStrategy
              )

bundles =
  [ bundle "zsh-users/zsh-syntax-highlighting"
  , bundle "spwhitt/nix-zsh-completions"
  , bundle "zsh-users/zsh-completions"
  , bundle "Adjective-Object/nix-zsh-utility"
  , bundle "Adjective-Object/agnostpure/"

  , bundle "zsh-users/zsh-autosuggestions"

  -- If you use a plugin that doesn't have a *.plugin.zsh file. You can set a
  -- more liberal sourcing strategy.
  --
  -- , (bundle "some/stupid-plugin") { sourcingStrategy = antigenSourcingStrategy }

  -- If you use a plugin that has sub-plugins. You can specify that as well
  --
  -- NOTE: If you want to use oh-my-zsh for real (please don't), you still need
  -- to set the $ZSH env var manually.
  -- , (bundle "robbyrussell/oh-my-zsh")
  --      { sourcingLocations = [ "plugins/command-not-found" ] }

  -- Sourcing a list of files
  -- , (bundle "alfredodeza/zsh-plugins")
  --    { sourcingStrategy = filePathsSourcingStrategy
  --                          [ "vi/zle_vi_visual.zsh"
  --                          , "pytest/pytest.plugin.zsh"
  --                          ] }

  -- Alternatively, this way will give you the same result
  -- , (bundle "alfredodeza/zsh-plugins")
  --    { sourcingStrategy = antigenSourcingStrategy
  --    , sourcingLocations = [ "vi"
  --                          , "pytest"
  --                          ] }

  -- vvv    Add your plugins here    vvv
  ]

config = defaultConfig { plugins = bundles }

main :: IO ()
main = antigen config

