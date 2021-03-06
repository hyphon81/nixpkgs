{ stdenv
, buildPythonPackage
, fetchPypi
, pkgs-docker
, docker
, traitlets
, python-json-logger
, escapism
, jinja2
, ruamel_yaml
, pyyaml
, pytest
, wheel
, pytestcov
, pythonAtLeast
}:

buildPythonPackage rec {
  version = "0.6.0";
  pname = "jupyter-repo2docker";
  disabled = !(pythonAtLeast "3.4");

  src = fetchPypi {
    inherit pname version;
    sha256 = "32c6dc6fd2402d6f5a955f8ab59299097bb5f4972c7dcc6fe2a8fe4c96dcab27";
  };

  checkInputs = [ pytest pyyaml wheel pytestcov ];
  propagatedBuildInputs = [ pkgs-docker docker traitlets python-json-logger escapism jinja2 ruamel_yaml ];

  # tests not packaged with pypi release
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://repo2docker.readthedocs.io/en/latest/;
    description = "Repo2docker: Turn code repositories into Jupyter enabled Docker Images";
    license = licenses.bsdOriginal;
    maintainers = [ maintainers.costrouc ];
  };
}
