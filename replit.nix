# replit.nix modded by tomcat
{ pkgs }: {
    deps = [
        pkgs.bashInteractive
        pkgs.graalvm8-ce
        pkgs.unzip
        pkgs.nginx
        pkgs.busybox
        pkgs.tmux
        pkgs.python38Full
    ];
    env = {
      PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
        # Needed for pandas / numpy
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        # Needed for pygame
        pkgs.glib
        # Needed for matplotlib
        pkgs.xorg.libX11
        # other things
      ];
      PYTHONBIN = "${pkgs.python38Full}/bin/python3.8";
      LANG = "en_US.UTF-8";
    };
}