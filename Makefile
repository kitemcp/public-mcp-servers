# Build targets
.PHONY: render deploy clean

render:
	kite deploy-dir apps ./apps-rendered -t flycd -d

deploy:
	kite deploy-dir apps ./apps-rendered -t flycd

clean:
	rm -rf ./apps-rendered

# Help target
.PHONY: help
help:
	@echo "Make targets:"
	@echo "  all               - Deploy the application"
	@echo "  render            - Render the application"
	@echo "  deploy            - Deploy using kite deploy with src/app.yaml"
	@echo "  clean             - Clean up the output directory"
	@echo "  help              - Display this help message"
