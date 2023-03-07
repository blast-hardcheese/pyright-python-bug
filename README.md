pyright-python bug
===

Run the following...
```
$ docker build -t bugrepro .
```

to get the following...
```
[+] Building 16.7s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                0.0s
 => => transferring dockerfile: 862B                                                                0.0s
 => [internal] load .dockerignore                                                                   0.0s
 => => transferring context: 2B                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.11.1-alpine3.17                         0.7s
 => [1/8] FROM docker.io/library/python:3.11.1-alpine3.17@sha256:d8b0703ce84fe5a52d485f212e9d852bc  0.0s
 => [internal] load build context                                                                   0.0s
 => => transferring context: 93B                                                                    0.0s
 => CACHED [2/8] WORKDIR /app                                                                       0.0s
 => CACHED [3/8] RUN if [ "linux/arm64" = "linux/arm64" ]; then         apk add gcc libc-dev libff  0.0s
 => CACHED [4/8] RUN python -c 'from urllib.request import urlopen; print(urlopen("https://install  0.0s
 => CACHED [5/8] COPY README.md pyproject.toml poetry.lock ./                                       0.0s
 => CACHED [6/8] RUN apk add libgcc                                                                 0.0s
 => [7/8] RUN poetry install --no-interaction --no-ansi -vvv --no-root --only pyright               4.2s
 => ERROR [8/8] RUN poetry run pyright                                                             11.6s
------
 > [8/8] RUN poetry run pyright:
#12 1.042 /app/.venv/lib/python3.11/site-packages/nodeenv.py:26: DeprecationWarning: 'pipes' is deprecated and slated for removal in Python 3.13
#12 1.042   import pipes
#12 1.303  * Install prebuilt node (19.7.0) ..... done.
#12 10.99 env: can't execute 'node': No such file or directory
#12 10.99 Traceback (most recent call last):
#12 10.99   File "/app/.venv/bin/pyright", line 8, in <module>
#12 10.99     sys.exit(entrypoint())
#12 10.99              ^^^^^^^^^^^^
#12 10.99   File "/app/.venv/lib/python3.11/site-packages/pyright/cli.py", line 34, in entrypoint
#12 10.99     sys.exit(main(sys.argv[1:]))
#12 10.99              ^^^^^^^^^^^^^^^^^^
#12 10.99   File "/app/.venv/lib/python3.11/site-packages/pyright/cli.py", line 19, in main
#12 10.99     return run(*args, **kwargs).returncode
#12 10.99            ^^^^^^^^^^^^^^^^^^^^
#12 10.99   File "/app/.venv/lib/python3.11/site-packages/pyright/cli.py", line 25, in run
#12 10.99     pkg_dir = install_pyright(args, quiet=None)
#12 10.99               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#12 10.99   File "/app/.venv/lib/python3.11/site-packages/pyright/_utils.py", line 61, in install_pyright
#12 11.00     node.run(
#12 11.00   File "/app/.venv/lib/python3.11/site-packages/pyright/node.py", line 115, in run
#12 11.00     return subprocess.run(node_args, env=env, **kwargs)
#12 11.00            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#12 11.00   File "/usr/local/lib/python3.11/subprocess.py", line 571, in run
#12 11.00     raise CalledProcessError(retcode, process.args,
#12 11.00 subprocess.CalledProcessError: Command '['/root/.cache/pyright-python/nodeenv/bin/npm', 'install', 'pyright@1.1.296']' returned non-zero exit status 127.
------
executor failed running [/bin/sh -c poetry run pyright]: exit code: 1
```
