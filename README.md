# testenv

configuration for Temporal test environments

## Usage

Add this repository as a submodule:

```sh
❯ git submodule add https://github.com/RTradeLtd/testenv
❯ git add .
❯ git commit
```

Then:

```
❯ ( cd testenv ; make testenv )
```

Add this to your dependency installation script:

```sh
❯ git submodule update --init
```

To update:

```
❯ ( cd testenv ; git pull origin master )
❯ git add .
❯ git commit
```
