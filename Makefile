CONFIGS=$(wildcard config/*)

usage:
	@echo "Usage: make config/platform"
	@echo "  make the configuration of any supported platform."

$(CONFIGS):
	./scripts/configure.sh $(notdir $@)

clean:
	rm -rf output/ src/

mrproper:
	rm -rf output/ src/ download/

.PHONY: usage clean $(CONFIGS)
