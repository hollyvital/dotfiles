{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sublime3
    sublime-merge
  ];
}
