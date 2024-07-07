# Visualise Cycles In Terraform

## Requirments

graphviz

## Command

```sh
terraform graph -draw-cycles | dot -Tsvg > graph.svg
```