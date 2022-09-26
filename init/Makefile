compile:
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
			-f asic.f				\
			| tee run1.log

run:
	./simv	+vcs+lic+wait			\
			+define+SVA				\
			+vcs+flush+log			\
			+seed=`date +%N`		\
			+plusargs_save			\
			| tee run2.log

vd:	
	verdi -sverilog +define+SVA -f asic.f -ssf tb.fsdb&

clean:
	rm simv *.fsdb novas* run* ucli.key
	rm -r simv.daidir verdiLog csrc
