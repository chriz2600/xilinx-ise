# quartus-lite

Xilinx ISE 14.7 docker.

I included a `xilinx` shell script, which allows execution of e.g. `impact` inside the docker container. The current working directory is mounted to `/build`.

Example:
```
xilinx impact -batch my.cmd
```
`xilinx` command is executed in the current working directory. 
Just copy `xilinx` to a directory in your `PATH`.
