{ pkgs ? import ./nix/pkgs.nix }:

let
  opencv-type-stub = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/bschnurr/python-type-stubs/add-opencv/cv2/__init__.pyi";
    sha256 = "sha256-IkE/b5/bZe7oC95xTwxrlH3iZYnK3pNCarz8QYxVecY=";
  };
  opencv4-includes-type-stub = pkgs.python311Packages.opencv4.overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall or "" + ''
      mkdir -p $out/${pkgs.python3.sitePackages}/cv2
      cp ${opencv-type-stub} $out/${pkgs.python3.sitePackages}/cv2/__init__.pyi
    '';
  });
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    actionlint
    python311
    black
    mypy
    opencv4-includes-type-stub
    python311Packages.pytest
  ];
}
