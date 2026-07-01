{ ... }:

# https://github.com/nixos/nixpkgs/issues/536623
# vesktop commit: 4b3d28a (hasnt hit unstable yet)
final: prev: {
  pnpm_10_29_2 = final.pnpm_10;
}
