export S1=$(CURDIR)
export SUB=$(S1)/submodule

BUILD=$(S1)/build
COVERAGE=$(S1)/coverage
LOG=$(S1)/log

EW_HL := | grep -E "WARNING-|ERROR-|" --color=auto
EW_O := | grep -E "WARNING-|ERROR-" --color=auto || true

YA:=echo -ne "\033[1;33m> \033[0m";

$(BUILD):
	@mkdir -p $(BUILD)
	@echo "*" > $(BUILD)/.gitignore
	@$(YA) echo "Created build directory"

$(COVERAGE):
	@mkdir -p $(COVERAGE)
	@echo "*" > $(COVERAGE)/.gitignore
	@$(YA) echo "Created Coverage directory"

$(LOG):
	@mkdir -p $(LOG)
	@echo "*" > $(LOG)/.gitignore
	@$(YA) echo "Created log directory"

.PHONY: COMPILE_ALL
COMPILE_ALL:
	@$(foreach flist, $(shell find $(S1)/hardware/filelist/ -type f -name "*.f"), make -s COMPILE FILE=$(flist);)

.PHONY: COMPILE
COMPILE:
	@make -s $(BUILD)
	@$(YA) echo "Compiling $(FILE)"
	@cd $(BUILD) && xvlog -sv -f $(FILE) $(EW_O)

.PHONY: clean
clean:
	@rm -rf $(BUILD)
	@$(YA) echo "Cleaned build directory"

.PHONY: clean_full
clean_full:
	@make -s clean
	@rm -rf $(COVERAGE)
	@$(YA) echo "Cleaned coverage directory"
	@rm -rf $(LOG)
	@$(YA) echo "Cleaned log directory"
