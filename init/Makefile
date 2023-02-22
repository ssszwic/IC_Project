# Todo: type Testbench
TESTBENCH = ../Testbench/
SRC = $(shell find ../ -name '*.v')
WORK_DIR = $(shell pwd)
SIMV = $(WORK_DIR)/simv
FILES = $(WORK_DIR)/asic.f

compile: $(SIMV)

$(SIMV): $(FILES)
	@echo ================================================
	@echo '#' compille
	@echo ================================================
	vcs		-sverilog				\
			-full64					\
			+vcs+lic+wait			\
			+define+SVA				\
			+v2k					\
			+lint=all,noTMR,noVCDE	\
			-debug_access+all		\
			+notimingcheck			\
			+nospecify				\
			-P /usr/synopsys/verdi/Verdi_N-2017.12-SP2/share/PLI/VCS/linux64/novas.tab	\
			/usr/synopsys/verdi/Verdi_N-2017.12-SP2/share/PLI/VCS/linux64/pli.a	\
			-f $^					\
			| tee run1.log
	@echo ================================================
	@echo '#' compille finished
	@echo ================================================

run: $(SIMV)
	@echo ================================================
	@echo '#' simulation
	@echo ================================================
	$(SIMV)	+vcs+lic+wait			\
			+define+SVA				\
			+vcs+flush+log			\
			+seed=`date +%N`		\
			+plusargs_save			\
			| tee run2.log
	@echo ================================================
	@echo '#' simulation finished
	@echo ================================================

$(FILES): $(TESTBENCH) $(SRC)
	@$(shell echo -e $(addsuffix \\n,$(TESTBENCH))$(addsuffix \\n,$(SRC)) > $(FILES))

vd:	
	verdi -sverilog +define+SVA -f asic.f -ssf tb.fsdb&

clean:
	-rm simv *.fsdb novas* run* ucli.key out $(FILES)
	-rm -r simv.daidir verdiLog csrc
