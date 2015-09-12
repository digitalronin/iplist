Iplist
======

  Elixir library and command-line tool to expand IP range(s) into a list of IP tuples

## Install

```elixir
defp deps do
  [
    {:iplist, "~> 1.0.0"}
  ]
end
```

Or, if you only want the command-line tool;

  make install

This will use mix to build an escript executable, and copy it to ~/bin/

## Usage (command-line executable)

```bash
$ ./iplist 1.2.3.4..1.2.3.5
1.2.3.4
1.2.3.5

$ ./iplist 1.2.3.4/31
1.2.3.4
1.2.3.5

$ cat foo
1.2.3.4
1.2.3.0/24
1.2.3.4..1.2.3.5

$ cat foo | ./iplist
1.2.3.4
1.2.3.0
1.2.3.1
...

```

## Usage (library)

See doc/index.html

## License

[LICENSE](LICENSE)
