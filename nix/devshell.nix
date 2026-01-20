{ system, inputs, ... }:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
pkgs.mkShell {
  packages = with pkgs; [
    obsidian
  ];

  NIXOS_OZONE_WL = "1";
}
