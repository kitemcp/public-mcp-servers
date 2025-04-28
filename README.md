# Kite Applications

This repository contains specifications for applications that will be deployed to the fly cloud using the kite deployment system. It maintains both application specifications and their rendered deployment outputs.

## Structure

- `apps/` - Contains YAML specifications for applications to be deployed
- `apps-out/` - Contains the rendered deployment artifacts generated from specifications
- `Makefile` - Contains commands for building and deploying applications

## Workflow

1. **Development**: Create or modify application specifications in the `apps/` directory
2. **Pull Request**: When a PR is created for changes in the `apps/` folder, an automated action will render the changes and commit them
3. **Review**: The rendered output allows evaluation of changes before they are merged
4. **Deployment**: Applications are only deployed once changes reach the main branch

## Adding a New Application

To add a new application:

1. Create a new YAML file in the `apps/` directory
2. Define the application metadata, runtime, scaling, and transport configuration
3. Create a pull request
4. Wait for the automated action to render the deployment artifacts
5. Review the changes and merge when ready

## Example Application Specification

```yaml
metadata:
  name: "application-name"
  organization: "org-name"

runtime:
  type: docker
  source:
    docker:
      image: "org/image:tag"

scaling:
  minReplicas: 0

transport:
  type: http
  port: 8080
```

## Commands

- `make fly` - Generate fly deployment configuration
- `make helm` - Generate Kubernetes Helm charts
- `make k8s` - Generate Kubernetes manifests
- `make k8s-kustomize` - Generate Kubernetes Kustomize configuration
- `make all` - Generate all deployment configurations
- `make clean` - Clean up generated output
