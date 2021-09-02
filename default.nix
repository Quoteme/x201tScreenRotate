{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "x201tScreenRotate";
  src = ./.;
  buildInputs = [
    pkgs.stdenv
    pkgs.libwacom
    pkgs.xf86_input_wacom
    pkgs.xorg.xrandr
  ];
  dontBuild = true;
  installPhase = ''
    mkdir -pv $out/bin/
    cp x201tScreenRotate.sh $out/bin/
    chmod +x $out/bin/x201tScreenRotate.sh
  '';
  meta = with stdenv.lib; {
    description = "A small script used to change the Thinkpad X201T screen rotation";
    license = licenses.gpl3;
    maintainers = with maintainers; [ quoteme ];
    homepage = "https://github.com/quoteme/x201tScreenRotate";
  };
}
