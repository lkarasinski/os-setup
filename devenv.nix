# https://devenv.sh/
{ pkgs, ... }:
{
	packages = with pkgs; [ 
		go
		gopls
		golangci-lint
		delve
		go-tools
	];

	enterShell = ''
		go version
		'';

	languages.go.enable = true;

	pre-commit.hooks.gofmt.enable = true;
	pre-commit.hooks.golangci-lint.enable = true;
}
