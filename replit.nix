{ pkgs }: {
  deps = [
    pkgs.mailman
    pkgs.vim
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}