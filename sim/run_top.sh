rm -rf simv* *.log work *.vpd *.key work csrc *.fsdb AN.DB verdi* novas*

SRC_DIR="../src"
TB_DIR="."

mkdir -p work
vlogan -full64 -sverilog -work work -file file.list

vcs vitis_demo_kernel -l comp.log +error+100 +lint=TFIPC-L -debug_pp -full64 -P /tools/synopsys/verdi/Q-2020.03-SP2/share/PLI/VCS/linux64/novas.tab /tools/synopsys/verdi/Q-2020.03-SP2/share/PLI/VCS/linux64/pli.a
#vcs vitis_demo_kernel -l comp.log +lint=TFIPC-L +lint=PCWM -debug_pp -full64 -P /tools/synopsys/verdi/Q-2020.03/share/PLI/VCS/linux64/novas.tab /tools/synopsys/verdi/Q-2020.03/share/PLI/VCS/linux64/pli.a

#./simv

#verdi wave_form.fsdb &
