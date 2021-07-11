{
  inputs = {
    gitIgnoreNix = {
      url = github:IvanMalison/gitignore.nix;
    };
  };
  outputs = { self, gitIgnoreNix, nixpkgs }: {
    overlay = final: prev: {
      haskellPackages = prev.haskellPackages.override (old: {
        overrides = final.lib.composeExtensions (old.overrides or (_: _: {})) (self: super: rec {
          xmonad = self.callCabal2nix "xmonad" (gitIgnoreNix.gitIgnoreSource ./.) { };
        });
      });
    };
  };
}
