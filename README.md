# Kite Applications

This repository contains specifications for applications that are hosted by Kite with Kite. These servers are freely available for public use, intended for hobby projects or testing purposes.

It maintains both application specifications and their rendered deployment outputs.

## Available MCP Server Endpoints

| Application | URL | Description |
|-------------|-----|-------------|
| Inspector | https://kite-mcp-inspector.fly.dev/ | Inspects incoming requests and provides details |
| Text Extractor | https://text-extractor.mcp.inevitable.fyi/mcp | Extracts text from various content |
| Time Server | https://time.mcp.inevitable.fyi/mcp | Provides time-related functionality |
| Everything Server | https://everything.mcp.inevitable.fyi/mcp | Multi-purpose server with various capabilities |
| Echo Server | https://echo.mcp.inevitable.fyi/mcp | Returns the request data back to the sender, useful for debugging and testing clients and applications |

## Structure

- `apps/` - Contains YAML specifications for applications to be deployed
- `apps-rendered/` - Contains the rendered deployment artifacts generated from specifications
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
4. Make an argument for the server being available for everyone.

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

- `make render` - Generate deployment artifacts from application specifications
- `make deploy` - Deploy applications to the fly cloud using kite
- `make clean` - Clean up generated output files in the apps-rendered directory
