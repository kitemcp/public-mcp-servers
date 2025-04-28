# Public MCP Servers

These MCP servers provide ready-to-use endpoints for testing and developing applications that implement the Model Context Protocol. Key benefits include:

- **Zero Setup**: Test your MCP client implementation without deploying your own server
- **Reference Implementation**: Learn MCP standards through working examples
- **Debugging Aid**: Use the Inspector to validate your client's request/response flow
- **Rapid Prototyping**: Build applications with MCP capabilities before committing to your own infrastructure

These servers are freely available for public use, primarily intended for hobby projects, development, and testing purposes. Please refrain from using them in high-traffic environments or production systems. These services are provided as a courtesy to the community and should not be commercialized or resold to others.

## Available MCP Server Endpoints

| Application | URL | Description |
|-------------|-----|-------------|
| Inspector | https://kite-mcp-inspector.fly.dev/ | Inspects incoming requests and provides details |
| Text Extractor | https://text-extractor.mcp.inevitable.fyi/mcp | Extracts text from various content |
| Time Server | https://time.mcp.inevitable.fyi/mcp | Provides time-related functionality |
| Everything Server | https://everything.mcp.inevitable.fyi/mcp | Multi-purpose server with various capabilities |
| Echo Server | https://echo.mcp.inevitable.fyi/mcp | Returns the request data back to the sender, useful for debugging and testing clients and applications |


## Getting Started

### Connecting to MCP Servers

You can interact with any of the MCP servers using standard HTTP requests. All servers implement the MCP specification and accept POST requests to their `/mcp` endpoint.

#### Using curl

Here's how to initialize a session with an MCP server:

```bash
curl -X POST https://echo.mcp.inevitable.fyi/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Accept: text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "initialize",
    "params": {
      "protocolVersion": "2024-11-05",
      "capabilities": {
        "roots": {
          "listChanged": true
        },
        "sampling": {}
      },
      "clientInfo": {
        "name": "ExampleClient",
        "version": "1.0.0"
      }
    }
  }'
```

#### Calling a Tool

Once initialized, you can call tools provided by the server. For example, using the Echo server:

```bash
curl -X POST https://echo.mcp.inevitable.fyi/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Accept: text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "echo",
      "arguments": {
        "message": "Hello, World!"
      }
    },
    "id": 1
  }'
```

### Using the Inspector

The Inspector server is particularly useful for debugging and understanding MCP:

1. Open https://kite-mcp-inspector.fly.dev/ in your browser
2. Connect your client to the Inspector endpoint
3. View a detailed breakdown of all messages exchanged between your client and the server
4. Analyze request/response patterns to debug issues or validate your implementation

The Inspector provides real-time visualization of the complete MCP message flow, making it an invaluable tool for development and troubleshooting.

### MCP TypeScript SDK Example

If you're using the TypeScript SDK, here's how to connect to one of the public servers:

```typescript
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StreamableHttpClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

const client = new Client({ name: "MyClient", version: "1.0.0" });
const transport = new StreamableHttpClientTransport({
  url: "https://echo.mcp.inevitable.fyi/mcp"
});

await client.connect(transport);

// Call the echo tool
const result = await client.callTool({
  toolName: "echo",
  args: { message: "Hello from TypeScript!" }
});

console.log(result);
```


## Structure

- `apps/` - Contains YAML specifications for applications to be deployed
- `apps-rendered/` - Contains the rendered deployment artifacts generated from specifications
- `Makefile` - Contains commands for building and deploying applications

## How to Add a New Server

This repository follows a GitOps workflow for adding and deploying new MCP servers:

1. **Create a Server Specification**: 
   - Add a new YAML file in the `apps/` directory with your server configuration
   - Define metadata, runtime, scaling parameters and transport settings
   - Ensure your server implements MCP correctly and serves a useful purpose

2. **Submit a Pull Request**:
   - Create a PR with your new server specification
   - Include a clear description of what your server does and why it should be publicly available
   - Explain how it benefits the broader MCP community
   
3. **Automated Rendering**:
   - When your PR is created, GitHub Actions will automatically render the deployment artifacts
   - These artifacts will be committed back to your PR in the `apps-rendered/` directory
   
4. **Review Process**:
   - Maintainers will review both your specification and the generated artifacts
   - You may be asked to make adjustments to ensure stability and security
   
5. **Deployment**:
   - Once approved and merged to main, your server will be deployed to fly.io
   - It will be available at its designated domain with the `/mcp` endpoint

### Example Server Specification

```yaml
metadata:
  name: "my-mcp-server"        # Will determine your server's URL
  organization: "personal"     # Organization namespace

runtime:
  type: docker
  source:
    docker:
      image: "myusername/my-mcp-server:latest"  # Your Docker image

scaling:
  minReplicas: 0   # Scale to zero when not in use (saves resources)
  maxReplicas: 1   # Maximum number of instances

transport:
  type: http
  port: 3000       # Port your server listens on inside the container

environment:
  - name: KITE_ID
    value: "my-mcp-server"     # Identifier for your server
```

### Requirements for New Servers

For a server to be accepted, it should:

1. Implement the MCP specification correctly
2. Serve a distinct purpose not already covered by existing servers
3. Be well-documented, both in code and in descriptive content
4. Have a stable container image available in a public registry
5. Be self-contained without dependencies on external processes or network calls
6. Be suitable for public use, with appropriate security consideration

## Commands

- `make render` - Generate deployment artifacts from application specifications
- `make deploy` - Deploy applications to the fly cloud using kite
- `make clean` - Clean up generated output files in the apps-rendered directory
