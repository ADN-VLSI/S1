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

export APB=$(SUB)/apb
export AXI=$(SUB)/axi
export COMMON_CELLS=$(SUB)/common_cells
export SOC=$(SUB)/SoC

####################################################################################################
# Internal Variables
####################################################################################################

BUILD=$(S1)/build
COVERAGE=$(S1)/coverage
LOG=$(S1)/log

TOP := $(or $(strip $(shell cat $(BUILD)/last_top 2>/dev/null)),s1_soc_tb)
SIMULATOR := $(or $(strip $(shell cat $(BUILD)/last_simulator 2>/dev/null)),VIVADO)

TEST := default

SEED := 0

DEBUG := 0

GUI := 0
ifneq ($(GUI),0)
	XSIM_ARGS += -gui --autoloadwcfg --view $(S1)/wcfg/snap_$(TOP).wcfg
else
	XSIM_ARGS += -runall
endif

.DEFAULT_GOAL := help

####################################################################################################
# Long Repeatative Commands
####################################################################################################

# Yello Arrow
YA := echo -ne "\033[1;33m> \033[0m";

ifeq ($(SIMULATOR),VIVADO)

EW_HL := | grep -E "WARNING:|ERROR:|" --color=auto
EW_O := | grep -E "WARNING:|ERROR:" --color=auto || true

INCDIR_FLAG := -i 
DEFINE_FLAG := -d 
LOG_FLAG := -log

COMPILE_TOOL := xvlog -sv

LINKER_TOOL := xelab
LINKER_TOOL_OP := -s
LINKER_TOOL_FLAGS := -debug typical -O3

else ifeq ($(SIMULATOR),VCS)

EW_HL := | grep -E "Warning-|Error-|" --color=auto
EW_O := | grep -E "Warning-|Error-" --color=auto || true

INCDIR_FLAG := +incdir+
DEFINE_FLAG := +define+
LOG_FLAG := -l

COMPILE_TOOL := vlogan -full64 -sverilog -nc

LINKER_TOOL := vcs -full64 -sverilog -nc -top
LINKER_TOOL_OP := -o
LINKER_TOOL_FLAGS :=

endif

####################################################################################################
# Definitions
####################################################################################################

# Compile all files in filelist as required, but only if there are changes in the files since the last compilation
define COMPILE_FILELIST
	touch $(BUILD)/compile_$(basename $(notdir $1))_sha512

	tmp_flist=$(BUILD)/tmp_flist; \
	rm -f $$tmp_flist; \
	while IFS= read -r line || [ -n "$$line" ]; do \
		if [[ "$$line" =~ ^[[:space:]]*-i[[:space:]]+(.+)[[:space:]]*$$ ]]; then \
			include_dir="$${BASH_REMATCH[1]}"; \
			eval "include_dir=\"$$include_dir\""; \
			find "$$include_dir" -type f | sort >> "$$tmp_flist"; \
		else \
			printf '%s\n' "$$line" >> "$$tmp_flist"; \
		fi; \
	done < "$1"; \
 	sed -i "s/^-.*//g" $$tmp_flist; \
	echo "$1" >> $$tmp_flist; \
	tmp_sha512=$(BUILD)/tmp_sha512; \
	rm -f $$tmp_sha512; \
	while IFS= read -r file || [ -n "$$file" ]; do \
		[[ -z "$$file" ]] && continue; \
		eval "file=\"$$file\""; \
		if [ ! -f "$$file" ]; then \
			echo "Missing file in filelist: $$file" >&2; \
			exit 1; \
		fi; \
		sha512sum "$$file"; \
	done < "$$tmp_flist" | sha512sum | awk '{print $$1}' > $$tmp_sha512;

	if [ -f $(BUILD)/compile_$(basename $(notdir $1))_sha512 ]; then \
		existing_hash=$$(cat $(BUILD)/compile_$(basename $(notdir $1))_sha512); \
		new_hash=$$(cat $(BUILD)/tmp_sha512); \
		if [ "$$existing_hash" = "$$new_hash" ]; then \
			$(YA) echo "Skipping  $1"; \
			rm -f $(BUILD)/tmp_sha512; \
			exit 0; \
		fi; \
	fi;	\
	$(YA) echo "Compiling $1"; \
	rm -f $(BUILD)/elaborate_*; \
	cp $1 $(BUILD)/tmp_flist; \
	sed -i "s/^-d /$(DEFINE_FLAG)/g" $(BUILD)/tmp_flist; \
	sed -i "s/^-i /$(INCDIR_FLAG)/g" $(BUILD)/tmp_flist; \
	cd $(BUILD) && $(COMPILE_TOOL) -f $(BUILD)/tmp_flist $(LOG_FLAG) $(LOG)/compile_$(basename $(notdir $1)).log $(EW_O); \
	mv $(BUILD)/tmp_sha512 $(BUILD)/compile_$(basename $(notdir $1))_sha512;
	rm -f $(BUILD)/tmp_flist $(BUILD)/tmp_sha512;
	grep "ERROR:" $(LOG)/compile_$(basename $(notdir $1)).log > /dev/null && rm -f $(BUILD)/compile_$(basename $(notdir $1))_sha512 || true;
endef

# Search all systemverilog hardware file lists and compile them
define COMPILE
	@$(foreach flist, $(shell find $(S1)/hardware/filelist/ -type f -name "*.f"), $(call COMPILE_FILELIST,$(flist)))
endef

# Elaborate the design, but only if there are changes in the files since the last elaboration
define ELABORATE
	if [ -f $(BUILD)/elaborate_$1 ]; then \
		$(YA) echo "Skipping elaboration of $1"; \
	else \
		$(YA) echo "Elaborating design $1"; \
		rm -f $(BUILD)/elaborate_$1; \
		cd $(BUILD) && $(LINKER_TOOL) $1 $(LINKER_TOOL_OP) snap_$1 $(LINKER_TOOL_FLAGS) -timescale=1ps/1fs $(LOG_FLAG) $(LOG)/elaborate_$1.log $(EW_O); \
		grep "ERROR:" $(LOG)/elaborate_$1.log > /dev/null || touch $(BUILD)/elaborate_$1; \
	fi
endef

# Check all files under $(S1)/hardware/include start with `s1_`
define CHECK_FILE_NAME_PREFIX
	invalid_files=$$(find $(S1)/hardware/include -type f ! -name "s1_*"); \
	if [ -n "$$invalid_files" ]; then \
		printf '%s\n' "$$invalid_files" | while IFS= read -r file; do \
			printf 'NAMING ERROR: %s\n' "$$file" >&2; \
		done; \
		exit 1; \
	fi;
	invalid_files=$$(find $(S1)/hardware/source -type f ! -name "s1_*"); \
	if [ -n "$$invalid_files" ]; then \
		printf '%s\n' "$$invalid_files" | while IFS= read -r file; do \
			printf 'NAMING ERROR: %s\n' "$$file" >&2; \
		done; \
		exit 1; \
	fi;
	invalid_files=$$(find $(S1)/hardware/testbench -type f ! -name "s1_*"); \
	if [ -n "$$invalid_files" ]; then \
		printf '%s\n' "$$invalid_files" | while IFS= read -r file; do \
			printf 'NAMING ERROR: %s\n' "$$file" >&2; \
		done; \
		exit 1; \
	fi;
endef

# Build environment: create build, log and coverage directories, compile and elaborate the design
define ENV_BUILD
	make -s $(BUILD)
	make -s $(LOG)
	git submodule update --init --depth 1
	$(call CHECK_FILE_NAME_PREFIX)
	$(call COMPILE)
	$(call ELABORATE,$1)
endef

ifeq ($(SIMULATOR),VIVADO)
define SIM_CHECKS
	echo "--testplusarg TEST=$(TEST)" > build/sim_args
	echo "--testplusarg DEBUG=$(DEBUG)" >> build/sim_args
	echo "--testplusarg SEED=$(SEED)" >> build/sim_args
endef
else ifeq ($(SIMULATOR),VCS)
define SIM_CHECKS
	echo "+TEST=$(TEST)" > build/sim_args
	echo "+DEBUG=$(DEBUG)" >> build/sim_args
	echo "+SEED=$(SEED)" >> build/sim_args
endef
endif

####################################################################################################
# Rules
####################################################################################################

# Default target to show help message
.PHONY: help
help:
	@echo -e ""
	@echo -e "\033[1;35mAvailable targets:\033[0m"
	@echo -e "\033[0;32m  help        \033[0m - Show this help message"
	@echo -e "\033[0;32m  simulate    \033[0m - Build environment and run simulation"
	@echo -e "\033[0;32m  clean       \033[0m - Remove build artifacts"
	@echo -e "\033[0;32m  clean_full  \033[0m - Remove build artifacts, coverage and logs"
	@echo -e ""
	@echo -e "\n\033[1;35mVariables:\033[0m"
	@echo -e "\033[0;33m  TOP         \033[0m - Specify the top-level testbench (default: saved value or s1_soc_tb)"
	@echo -e "\033[0;33m  SIMULATOR   \033[0m - Select the simulator (default: saved value or VIVADO)"
	@echo -e "\033[0;33m  TEST        \033[0m - Specify the test to run (default: default)"
	@echo -e "\033[0;33m  SEED        \033[0m - Specify the random seed for the test (default: 0)"
	@echo -e "\033[0;33m  DEBUG       \033[0m - Enable debug mode (default: 0)"
	@echo -e "\033[0;33m  GUI         \033[0m - Enable GUI mode for simulation (default: 0)"

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

# Clear build directory
.PHONY: clean
clean:
	@rm -rf $(BUILD)
	@$(YA) echo "Cleaned build directory"

# Clear coverage and log directories
.PHONY: clean_records
clean_records:
	@rm -rf $(COVERAGE)
	@$(YA) echo "Cleaned coverage directory"
	@rm -rf $(LOG)
	@$(YA) echo "Cleaned log directory"

# Clear build, coverage and log directories
.PHONY: clean_full
clean_full:
	@make -s clean
	@make -s clean_records

.PHONY: simulate
simulate:
	@echo -e "\033[1;33mSIMULATOR: $(SIMULATOR)\nTOP: $(TOP)\033[0m"
	@last_simulator="$$(cat $(BUILD)/last_simulator 2>/dev/null)"; \
	if [ -n "$$last_simulator" ] && [ "$$last_simulator" != "$(SIMULATOR)" ]; then \
		$(YA) echo "Simulator changed from $$last_simulator to $(SIMULATOR). Cleaning build artifacts."; \
		make -s clean; \
	fi
	@make -s $(BUILD)
	@echo "$(TOP)" > $(BUILD)/last_top
	@echo "$(SIMULATOR)" > $(BUILD)/last_simulator
	@$(call ENV_BUILD,$(TOP))
	@$(call SIM_CHECKS)
	@make -s $(COVERAGE)
ifeq ($(SIMULATOR),VIVADO)
	@cd $(BUILD) && xsim snap_$(TOP) $(XSIM_ARGS) $(LOG_FLAG) $(LOG)/simulate_$(TOP)_$(TEST)_$(shell date +%Y%m%d_%H%M%S).log $(EW_HL)
else ifeq ($(SIMULATOR),VCS)
	@cd $(BUILD) && ./snap_$(TOP) $(LOG_FLAG) $(LOG)/simulate_$(TOP)_$(TEST)_$(shell date +%Y%m%d_%H%M%S).log $(EW_HL)
endif
