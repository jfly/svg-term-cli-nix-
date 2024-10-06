{
  fetchYarnDeps,
  lib,
  src,
  stdenv,
  yarnConfigHook,
  yarnBuildHook,
  yarnInstallHook,
  nodejs,
}:

stdenv.mkDerivation {
  pname = "svg-term-cli";

  # https://github.com/NixOS/nix/issues/8163
  version = builtins.concatStringsSep "-" (builtins.match "(.{4})(.{2})(.{2}).*" src.lastModifiedDate);

  inherit src;

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-W4fIfI//wSSqlapvETYce6cZ3LX5heB79d1zjWflbCc=";
  };

  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    yarnInstallHook
    nodejs
  ];

  meta = {
    description = "Share terminal sessions via SVG and CSS";
    homepage = "https://github.com/marionebl/svg-term-cli";
    maintainers = [ ];
    mainProgram = "svg-term";
    platforms = lib.platforms.all;
  };
}
