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

export AXI=$(SUB)/axi
export COMMON=$(SUB)/common
export COMMON_CELLS=$(SUB)/common_cells
export SOC=$(SUB)/SoC

####################################################################################################
# Internal Variables
####################################################################################################

GUI := 0
ifneq ($(GUI),0)
	XSIM_ARGS += -gui
else
	XSIM_ARGS += -runall
endif

BUILD=$(S1)/build
COVERAGE=$(S1)/coverage
LOG=$(S1)/log

####################################################################################################
# Long Repeatative Commands
####################################################################################################

# Yello Arrow
YA := echo -ne "\033[1;33m> \033[0m";

# Error Warning Highlight
EW_HL := | grep -E "WARNING:|ERROR:|" --color=auto

# Error Warning Highlight Only
EW_O := | grep -E "WARNING:|ERROR:" --color=auto || true

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
	cd $(BUILD) && xvlog -sv -f $1 -log $(LOG)/compile_$(basename $(notdir $1)).log $(EW_O); \
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
		cd $(BUILD) && xelab $1 -s snap_$1 -debug typical -log $(LOG)/elaborate_$1.log $(EW_O); \
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

.PHONY: simulate
simulate:
	@$(call ENV_BUILD,$(TOP))
	@make -s $(COVERAGE)
	@cd $(BUILD) && xsim snap_$(TOP) $(XSIM_ARGS) -log $(LOG)/simulate_$(TOP)_$(TEST)_$(shell date +%Y%m%d_%H%M%S).log $(EW_HL)
