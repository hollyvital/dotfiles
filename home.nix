{ config, pkgs, ... }:

let
  xmonad = pkgs.xmonad-with-packages.override {
    packages = p: with p; [ xmonad-contrib xmonad-extras ];
  };

in

{
  imports = [
    /home/holly/git/vital-nix/user/feh-background.nix
    /home/holly/git/vital-nix/user/thinkpad.nix
    /home/holly/git/vital-nix/user/software-workstation.nix
  ];

  home = {
    username = "holly";
    homeDirectory = "/home/holly";
    file = {
      ".xmonad/xmonad.hs".source = ./xmonad.hs;
      ".zshrc".source = ./zshrc;
      "lsd/config.yaml".source = ./lsd.yaml;
      ".tmux.conf".source = ./tmux.conf;
      ".zprofile".source = ./zprofile;
      ".config/polybar/cal_remind.sh" = {
        executable = true;
        # if google refuses to authorize you may need a vital specific client_id. I can hook you up
        text = ''
          gcalcli agenda --nostarted --military --tsv today tomorrow | head -n 1 | cut -f 2,5 | sed 's/\t/ - /' | { read -r -t1 val && echo "$val" || echo 'NO MORE MEETINGS TODAY!' ; }
          gcalcli remind 0
        '';
      };
      ".config/battery_check.sh" = {
        executable = true;
        text = ''
          #! /usr/bin/env nix-shell
          #! nix-shell -i bash -p acpi dunst 
          export DISPLAY=:0
          XAUTHORITY=/home/holly/.Xauthority
          percent=`acpi -b | grep -P -o '[0-9]+(?=%)'`
          if [ $percent -le 15 ]
          then
            dunstify -a "BATTERY LOW" -u critical "danger!" "Running out of magic pixies!"
          fi
          echo 'ran batt' >> /home/holly/cron.log
        '';
      };
    };

    packages = with pkgs; [
      nixos-option
      zsh-prezto
      neovim
      hexyl # command line hex viewer with pretty colours
      #google-chrome
      gnumake
      ctags
      glibc.dev
      firefox
      ripgrep
      file
      slack
      zoom-us
      gotop
      binutils
      usbutils
      libftdi
      libusb
      exa
      silver-searcher
      glxinfo 
      sublime-merge #Cozy merge conflict gui
      vimpc
      fd
      fzf
      hicolor-icon-theme
      dunst
#      (dunst.override { dunstify = true; })
      gcalcli
      terraform
      unzip
      virt-manager
      bmap-tools
      screen
      (import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/9ffd16b3850536094ca36bc31520bb15a6d5a9ef.tar.gz") {}).cachix
      remmina
      krita #Move over, Photoshop!
      kicad #Circuit board software
      vlc
      fd  #find but actually usable
      bat #cat with syntax highlighting
      saleae-logic-2 
      hexedit # Wanna read a wall of hex?
      lsd
      tmux
      xxd
      patchelf
      gdb
      openocd
      foxitreader
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_DEFAULT_COMMAND = "fd --type f";
      TERM = "xterm-256color";
    };

    stateVersion = "21.05";
  };

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  services = {
    mpd = {
      enable = true;
    };
    dunst = {
      enable = true;
      # details at https://github.com/dunst-project/dunst/blob/master/dunstrc
      settings = {
        global = {
          follow = "keyboard";
          geometry = "800x200-150-20";
          separator_height = 8;
          padding = 16;
          horizontal_padding = 16;
          corner_radius = 6;
          mouse_left_click = "do_action";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
          ellipsize = "end";
          vertical_alignment = "center";
          notification_height = 150;
          word_wrap = true;
          format = "<b>%a</b> - <i>%s</i>\\n%b";
          show_indicators = false;
          line_height = 2;
        };
      };
    };
  };

  manual.manpages.enable = false;
  programs = {
    home-manager.enable = true;

    neovim = {
      viAlias = true;
      vimAlias = true;
      package = pkgs.neovim-nightly;
    };
    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "hollyvital";
      userEmail = "holly@vitalbio.com";
      extraConfig = {
        core.editor = "$EDITOR";
        pull.rebase = true;
        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        add.interactive.useBuiltin = false;
        include.path = "${builtins.fetchurl "https://raw.githubusercontent.com/dandavison/delta/4c879ac1afca68a30c9a100bea2965b858eb1853/themes.gitconfig"}";
        delta = {
          features = "chameleon";
          navigate = true;
          light = false;
        };
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
    };

    jq.enable = true;
    man.enable = true;

    kitty = {
      enable = true;
      settings = {
        foreground = "#f8f8f2";
        background = "#272822";
        selection_foreground = "#f8f8f2";
        selection_background = "#49483e";
        font_family = "Fira Code Retina";
        font_size = "9";
        visual_bell_duration = "0.05";
        term = "xterm-256color";
      };
    };

    firefox = {
      profiles.holly = {
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.bookmarks.editDialog.confirmationHintShowCount" = 3;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.contentblocking.category" = "standard";
          "browser.ctrlTab.recentlyUserOrder" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.section.hightlights" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.uidensity" = 20;
          "browser.search.region" = "US";
          "browser.search.suggest.enabled" = false;
          "browser.tabs.loadInBackground" = false;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.placeholderName.private" = "DuckDuckGo";
          "browser.theme.toolbar-theme" = 0;
          #"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "extensions.activeThemeID" = "e8f3b919-d290-4270-b66f-29f3fdbb1986";
          "extensions.ui.theme.hidden" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.showHome" = false;
          "extensions.pocket.onSaveRecs" = false;
          "layout.css.devPixelsPerPx" = 2;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "ui.systemUsesDarkTheme"= 1;
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
        ublock-origin
        solarized-light
      ];
    };
  };


  xdg.configFile = {
    "nvim/init.vim".source = ./nvim/init.vim;
    "polybar/config".source = ./polybar;
  };

  xresources.properties = {
    # special
    "*.foreground"  = "#d1d1d1";
    # *.background:   #221e2d
    "*.cursorColor" = "#d1d1d1";

    # black
    "*.color0"   = "#272822";
    "*.color8"   = "#75715e";

    # red
    "*.color1"   = "#f92672";
    "*.color9"   = "#f92672";

    # green
    "*.color2"   = "#a6e22e";
    "*.color10"  = "#a6e22e";

    # yellow
    "*.color3"   = "#f4bf75";
    "*.color11"  = "#f4bf75";

    # blue
    "*.color4"   = "#66d9ef";
    "*.color12"  = "#66d9ef";

    # magenta
    "*.color5"   = "#ae81ff";
    "*.color13"  = "#ae81ff";

    # cyan
    "*.color6"   = "#a1efe4";
    "*.color14"  = "#a1efe4";

    # white
    "*.color7"   = "#f8f8f2";
    "*.color15"  = "#f9f8f5";

    #"Xft.dpi"       = 192;
    "Xft.dpi"       = 96;
    "Xft.antialias" = true;
    "Xft.hinting"   = true;
    "Xft.rgba"      = "rgb";
    "Xft.autohint"  = false;
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";

    "*termname"           = "xterm-256color";
    "dmenu.selforeground" = "#FFFFFF";
    "dmenu.background"    = "#000000";
    "dmenu.selbackground" = "#0C73C2";
    "dmenu.foreground"    = "#A0A0A0";
  };

  xsession = {
    enable = true;

    windowManager.command = "${xmonad}/bin/xmonad";
  };
}

