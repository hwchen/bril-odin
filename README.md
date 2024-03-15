Uses submodules to track bril dependencies `brili` and `bril2json` and `bril2text`.

`git submodule init` and `git submodule update`.

Nix sets up a venv for the python utils.

`brili` is installed into `~/.deno/bin`.

## quickstart

```shell
nix develop # (or automatic using direnv)
git submodule init && gitsubmodule update
deno install bril/brili.ts
cd bril/bril-txt && pip install flit && flit install --symlink
```
