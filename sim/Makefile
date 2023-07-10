sim:
	cp ${SIM_DIR}/tb_top.sh ${SIM_DIR}/current_run_top.sh
	sed -i 's/vlogan_opts="-full64 -kdb -v2005"/vlogan_opts="-full64 -kdb -v2005 ${DEFINE}"/g' ${SIM_DIR}/current_run_top.sh
	sed -i 's/vcs_sim_opts="-kdb -lca -ucli -licqueue -l simulate.log"/vcs_sim_opts="-kdb -lca -ucli -licqueue -l simulate.log +TESTNAME=${TESTNAME}"/g' ${SIM_DIR}/current_run_top.sh
	cd ${SIM_DIR};	pwd; ./current_run_top.sh 

clean:
	rm -rf run_dir*
	cd vcs;	pwd; ./tb_top.sh -reset_run

