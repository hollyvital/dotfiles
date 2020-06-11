{ config, pkgs, ... }:

{
  programs.autorandr = {
    enable = true;
    profiles = {
      "default" = {
        fingerprint = {
          "eDP-1-1" = "00ffffffffffff0006afeb4200000000211c0104b522137802ef95a35435b5260f50540000000101010101010101010101010101010152d000a0f0703e803020350058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe00423135365a414e30342e32200a019a02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          "eDP-1-1" = {
            enable = true;
            crtc = 4;
            mode = "3840x2160";
            position = "0x0";
            rate = "60.00";
          };
        };
      };
      "desk-home" = {
        fingerprint = {
          "DP-1" = "00ffffffffffff001e6d07771eeb0500031d0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a202020015e0203197144900403012309070783010000e305c000e3060501023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
          "eDP-1-1" = "00ffffffffffff0006afeb4200000000211c0104b522137802ef95a35435b5260f50540000000101010101010101010101010101010152d000a0f0703e803020350058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe00423135365a414e30342e32200a019a02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          "eDP-1-1" = {
            crtc = 4;
            enable = true;
            mode = "3840x2160";
            position = "4800x0";
            rate = "60.00";
          };
          "DP-1" = {
            crtc = 0;
            enable = true; 
            primary = true;
            position = "0x0";
            rate = "60.00";
            mode = "3840x2160";
            scale = {
              x = 1.25;
              y = 1.25;
            };
          };
        };
      };
    };
  };
}

