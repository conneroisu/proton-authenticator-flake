# Proton Authenticator for NixOS
#
# This flake packages Proton Authenticator from the official .deb package
# to work on NixOS systems.
{
  description = "Proton Authenticator for NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = {
        default = pkgs.stdenv.mkDerivation rec {
          pname = "proton-authenticator";
          version = "1.0.0";

          src = pkgs.fetchurl {
            url = "https://proton.me/download/authenticator/linux/ProtonAuthenticator_${version}_amd64.deb";
            sha256 = "sha256-Ri6U7tuQa5nde4vjagQKffWgGXbZtANNmeph1X6PFuM=";
          };

          nativeBuildInputs = with pkgs; [
            dpkg
            autoPatchelfHook
            wrapGAppsHook3
            makeWrapper
          ];

          buildInputs = with pkgs; [
            gtk3
            glib
            pango
            cairo
            gdk-pixbuf
            atk
            webkitgtk_4_1
            libsoup_3
          ];

          unpackPhase = ''
            runHook preUnpack
            dpkg-deb -x $src .
            runHook postUnpack
          '';

          installPhase = ''
            runHook preInstall
            
            mkdir -p $out/bin
            mkdir -p $out/share/applications
            mkdir -p $out/share/icons/hicolor
            
            # Copy the binary
            install -m755 usr/bin/proton-authenticator $out/bin/
            
            # Copy desktop file
            cp "usr/share/applications/Proton Authenticator.desktop" $out/share/applications/proton-authenticator.desktop
            
            # Fix desktop file to use correct binary name
            substituteInPlace $out/share/applications/proton-authenticator.desktop \
              --replace-fail "Exec=proton-authenticator" "Exec=$out/bin/proton-authenticator" \
              --replace-fail "Icon=proton-authenticator" "Icon=proton-authenticator"
            
            # Copy icons
            cp -r usr/share/icons/hicolor/* $out/share/icons/hicolor/
            
            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "Proton Authenticator - secure 2FA app";
            homepage = "https://proton.me/support/authenticator";
            license = licenses.unfree;
            platforms = ["x86_64-linux"];
            maintainers = with maintainers; [connerohnesorge];
          };
        };

        proton-authenticator = self.packages.${system}.default;
      };

      # Development shell for testing and debugging
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          dpkg
          file
          patchelf
        ];
      };
    });
}
