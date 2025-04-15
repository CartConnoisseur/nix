{ config, lib, inputs, ... }:
with lib;

let cfg = config.roles.minecraft; in {
  imports = [
    ./zenith
  ];
}
