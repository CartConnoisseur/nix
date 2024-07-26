{ config, lib, pkgs, ... }:

# Honestly, I'm pretty disappointed with
#   home-manager's `programs.vim`. It's kinda bad and
#   won't let me run `highlight` after `colorscheme`

lib.mkIf config.home.roles.dev.enable {
  home.file.".vim/vimrc".text = ''
    set number
    set relativenumber

    set termguicolors
    set background=dark
    colorscheme gruvbox

    syntax on

    highlight Normal guibg=#000000

    " Awesome magical color override from
    " https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
    augroup MyColors
      autocmd!
      autocmd ColorScheme * highlight Normal guibg=#000000
    augroup END
  '';

  home.file.".vim/pack/default/start/gruvbox".source = builtins.fetchGit {
    url = "https://github.com/morhetz/gruvbox.git";
    rev = "f1ecde848f0cdba877acb0c740320568252cc482";
  };

  home.file.".vim/pack/all/start/vim-nix".source = builtins.fetchGit {
    url = "https://github.com/LnL7/vim-nix.git";
    rev = "e25cd0f2e5922f1f4d3cd969f92e35a9a327ffb0";
  };
}
