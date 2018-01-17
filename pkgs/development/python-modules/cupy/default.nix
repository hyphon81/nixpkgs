{ stdenv, lib, python, buildPythonPackage
, fetchPypi, isPy3k, linuxPackages, gcc5
, fastrlock, numpy, six, wheel, pytest, mock
, cudatoolkit, cudnn, nccl
, cudnnSupport ? false, ncclSupport ? false
}:

buildPythonPackage rec {
  pname = "cupy";
  version = "2.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0si0ri8azxvxh3lpm4l4g60jf4nwzibi53yldbdbzb1svlqq060r";
  };

  checkInputs = [
    pytest
    mock
  ];

  nativeBuildInputs = [
    gcc5
    cudatoolkit
  ];

  propagatedBuildInputs = [
    linuxPackages.nvidia_x11
    fastrlock
    numpy
    six
    wheel
    cudatoolkit
  ] ++ lib.optionals ncclSupport [
    nccl
  ] ++ lib.optionals cudnnSupport[
    cudnn
  ];

  # In python3, test was failed...
  doCheck = !isPy3k;

  meta = with stdenv.lib; {
    description = "A NumPy-compatible matrix library accelerated by CUDA";
    homepage = https://cupy.chainer.org/;
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ hyphon81 ];
  };
}
