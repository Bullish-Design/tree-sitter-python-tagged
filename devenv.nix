{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env = {
    PROJ = "Tree-sitter-python-tagged";
#ENVVAR_LIST
    };

  # https://devenv.sh/packages/
  packages = [ 
    pkgs.git
#PACKAGE_LIST
    ];

  # https://devenv.sh/languages/
		languages.python = {
		   enable = true;
		   venv.enable = true;
		
		   uv.enable = true;
		
		 };
     languages.javascript = {
         enable = true;
         npm.enable = true;
         npm.install.enable = true;
       };

  # https://devenv.sh/processes/
#PROCESSES_INIT

  # https://devenv.sh/services/
#SERVICES_INIT

  # https://devenv.sh/scripts/
  scripts = {
    hello.exec = ''devenv-startup $PROJ'';
#SCRIPTS_LIST
    local-editable-install.exec = ''uv pip install -e .'';
    uv-freeze.exec = ''uv pip freeze > requirements.txt && echo && bump-ver && echo && uv pip uninstall . && uv pip freeze > requirements.txt && echo && echo "Requirements.txt frozen" && echo && local-editable-install'';

    };

  enterShell = ''
    hello
#ENTER_SHELL_SCRIPT
    local-editable-install
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
#ENTER_TEST_SCRIPT
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;
#PRE_COMMIT_HOOKS_INIT

  # See full reference at https://devenv.sh/reference/options/
}
