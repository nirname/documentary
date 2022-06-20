<style>
  svg {
    width: 400px;
  }
</style>

# Hello, my friend!

## Graph

```dot
digraph {
  A -> B
}
```

## Sequence graph

```seqdiag
seqdiag {
  browser -> webserver [label = "GET /index.html"];
  browser <-- webserver;
}
```