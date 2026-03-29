####################################################################################################
#
#    Author      : Foez Ahmed
#    GitHub ID   : foez-ahmed
#    License     : MIT License
#
####################################################################################################

####################################################################################################
# Export Variables
####################################################################################################

export SHELL=/bin/bash
export S1=$(CURDIR)
export SUB=$(S1)/submodule

####################################################################################################
# Internal Variables
####################################################################################################

BUILD=$(S1)/build
COVERAGE=$(S1)/coverage
LOG=$(S1)/log

####################################################################################################
# Long Repeatative Commands
####################################################################################################

# Yello Arrow
YA := echo -ne "\033[1;33m> \033[0m";

# Error Warning Highlight
EW_HL := | grep -E "WARNING-|ERROR-|" --color=auto

# Error Warning Highlight Only
EW_O := | grep -E "WARNING-|ERROR-" --color=auto || true

####################################################################################################
# Rules
####################################################################################################

# Create build directory
$(BUILD):
	@mkdir -p $(BUILD)
	@echo "*" > $(BUILD)/.gitignore
	@$(YA) echo "Created build directory"

# Create coverage directory
$(COVERAGE):
	@mkdir -p $(COVERAGE)
	@echo "*" > $(COVERAGE)/.gitignore
	@$(YA) echo "Created Coverage directory"

# Create log directory
$(LOG):
	@mkdir -p $(LOG)
	@echo "*" > $(LOG)/.gitignore
	@$(YA) echo "Created log directory"

# Compile all files in filelist
define COMPILE
	make -s $(BUILD)
	make -s $(LOG)
	$(YA) echo "Compiling $1"
	cd $(BUILD) && xvlog -sv -f $1 -log $(LOG)/compile_$(basename $(notdir $1)).log $(EW_O)
endef

# Search all systemverilog hardware file lists and compile them
.PHONY: COMPILE_ALL
COMPILE_ALL:
	@$(foreach flist, $(shell find $(S1)/hardware/filelist/ -type f -name "*.f"), $(call COMPILE,$(flist)))

# Clear build directory
.PHONY: clean
clean:
	@rm -rf $(BUILD)
	@$(YA) echo "Cleaned build directory"

# Clear build, coverage and log directories
.PHONY: clean_full
clean_full:
	@make -s clean
	@rm -rf $(COVERAGE)
	@$(YA) echo "Cleaned coverage directory"
	@rm -rf $(LOG)
	@$(YA) echo "Cleaned log directory"
