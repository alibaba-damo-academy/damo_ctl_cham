parameter DP_PP_COE_WIDTH = 39;
parameter PP_PP_COE_WIDTH = 39;
parameter RB_PP_COE_WIDTH = 35;
int fp_r0;
int fp_r1;
int flag; // $fscanf
// -------------------------------------
// dotproduct Ping-pong buffer init
// -------------------------------------
int _dp_idx;
logic [DP_PP_COE_WIDTH-1:0] _dp_temp0 [0:3*4096-1];
logic [DP_PP_COE_WIDTH-1:0] _dp_temp1 [0:3*4096-1];
    // --------------------------------------------
    // init dotprodct Ping-pong buffer tri_pp
    // --------------------------------------------

    task initialize_dp_tri_pp0_buf0_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_temp0[_dp_idx]);
        end

        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+2*4096 +: 512];
    endtask

    task initialize_dp_tri_pp0_buf1_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_temp0[_dp_idx]);
        end

        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+2*4096 +: 512];
    endtask

    task initialize_dp_tri_pp0_buf2_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_temp0[_dp_idx]);
        end

        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+0*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+1*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp0[0*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp0[1*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp0[2*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp0[3*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp0[4*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp0[5*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp0[6*512+2*4096 +: 512];
        `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp0[7*512+2*4096 +: 512];
    endtask

    task initialize_dp_tri_pp1_buf0_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_temp1[_dp_idx]);
        end

        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+2*4096 +: 512];
    endtask

    task initialize_dp_tri_pp1_buf1_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_temp1[_dp_idx]);
        end

        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+2*4096 +: 512];
    endtask

    task initialize_dp_tri_pp1_buf2_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_temp1[_dp_idx]);
        end

        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+0*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+1*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank = _dp_temp1[0*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank = _dp_temp1[1*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank = _dp_temp1[2*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank = _dp_temp1[3*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank = _dp_temp1[4*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank = _dp_temp1[5*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank = _dp_temp1[6*512+2*4096 +: 512];
        `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank = _dp_temp1[7*512+2*4096 +: 512];
    endtask

// -------------------------------------
// dotproduct Ping-pong buffer check
// -------------------------------------
logic [DP_PP_COE_WIDTH-1:0] _dp_model_data [0:16383];

    // -------------------------------------
    // check dotproduct Ping-pong buffer tri_pp
    // -------------------------------------

    task check_dp_tri_pp0_buf0_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_dp_tri_pp0_buf1_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_dp_tri_pp0_buf2_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp0.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_dp_tri_pp1_buf0_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_0.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_dp_tri_pp1_buf1_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_1.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_dp_tri_pp1_buf2_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _dp_model_data[_dp_idx]);
        end

        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[0*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[0].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[0*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[1*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[1].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[1*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+0*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[0].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+0*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+1*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[1].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+1*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+2*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[2].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+2*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+3*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[3].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+3*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+4*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[4].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+4*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+5*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[5].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+5*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+6*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[6].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+6*512+_dp_idx]
                );
                $finish;
            end
        end
        for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin
            if (`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx] === _dp_model_data[2*4096+7*512+_dp_idx])
            begin
            end
            else begin
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $display("`DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _dp_idx,
                         `DP.tri_pp1.polyvec_2.genblk1[2].polynomial.genblk1[7].base_bank.mem_bank[_dp_idx],
                         _dp_model_data[2*4096+7*512+_dp_idx]
                );
                $finish;
            end
        end
    endtask

// -------------------------------------
// dotproduct ciphertext uram init
// -------------------------------------
int _ct_idx;
int _ct_split_idx;

logic [DP_PP_COE_WIDTH-1:0] _ct_temp [6*4096-1:0];

    task initialize_dp_ctxt_uram(string filename, int n_split);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end

        for (_ct_split_idx = 0; _ct_split_idx < n_split; _ct_split_idx = _ct_split_idx + 1) begin
            for (_ct_idx = 0; _ct_idx < 6*4096; _ct_idx = _ct_idx + 1) begin
                flag = $fscanf(fp_r0, "%h", _ct_temp[_ct_idx]);
            end
            case (_ct_split_idx)
                0: begin
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt0.genblk1[0].uram_inst.mem = _ct_temp[(0+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt1.genblk1[0].uram_inst.mem = _ct_temp[(1+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt0.genblk1[1].uram_inst.mem = _ct_temp[(2+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt1.genblk1[1].uram_inst.mem = _ct_temp[(3+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt0.genblk1[2].uram_inst.mem = _ct_temp[(4+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[0].polyvec_ntt_ctxt1.genblk1[2].uram_inst.mem = _ct_temp[(5+1)*4096-1 -: 4096];
                end
                1: begin
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt0.genblk1[0].uram_inst.mem = _ct_temp[(0+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt1.genblk1[0].uram_inst.mem = _ct_temp[(1+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt0.genblk1[1].uram_inst.mem = _ct_temp[(2+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt1.genblk1[1].uram_inst.mem = _ct_temp[(3+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt0.genblk1[2].uram_inst.mem = _ct_temp[(4+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[1].polyvec_ntt_ctxt1.genblk1[2].uram_inst.mem = _ct_temp[(5+1)*4096-1 -: 4096];
                end
                2: begin
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt0.genblk1[0].uram_inst.mem = _ct_temp[(0+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt1.genblk1[0].uram_inst.mem = _ct_temp[(1+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt0.genblk1[1].uram_inst.mem = _ct_temp[(2+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt1.genblk1[1].uram_inst.mem = _ct_temp[(3+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt0.genblk1[2].uram_inst.mem = _ct_temp[(4+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[2].polyvec_ntt_ctxt1.genblk1[2].uram_inst.mem = _ct_temp[(5+1)*4096-1 -: 4096];
                end
                3: begin
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt0.genblk1[0].uram_inst.mem = _ct_temp[(0+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt1.genblk1[0].uram_inst.mem = _ct_temp[(1+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt0.genblk1[1].uram_inst.mem = _ct_temp[(2+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt1.genblk1[1].uram_inst.mem = _ct_temp[(3+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt0.genblk1[2].uram_inst.mem = _ct_temp[(4+1)*4096-1 -: 4096];
                    `DP.ctxt_polyvec.genblk2[3].polyvec_ntt_ctxt1.genblk1[2].uram_inst.mem = _ct_temp[(5+1)*4096-1 -: 4096];
                end
            endcase
        end
    endtask

// -------------------------------------
// preprocess Ping-pong buffer init
// -------------------------------------
int _pp_idx;
logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_temp0 [0:6*4096-1];
logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_temp1 [0:6*4096-1];
logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_temp0 [0:4*4096-1];
logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_temp1 [0:4*4096-1];

    // --------------------------------------------
    // init preprocess Ping-pong buffer tpp
    // --------------------------------------------

    task initialize_pp0_tpp_buf0_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_temp0[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp0_tpp_buf1_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_temp0[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp0_tpp_buf2_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_temp0[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp0[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp1_tpp_buf0_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_temp1[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp1_tpp_buf1_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_temp1[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp1_tpp_buf2_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_temp1[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[3*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[4*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_tpp_temp1[5*4096 + 7*512 + _pp_idx];
        end
    endtask

    // --------------------------------------------
    // init preprocess Ping-pong buffer dpp
    // --------------------------------------------

    task initialize_pp0_dpp_buf0_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_dpp_temp0[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp0_dpp_buf1_as_input(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_dpp_temp0[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp0[3*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp1_dpp_buf0_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_dpp_temp1[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 7*512 + _pp_idx];
        end
    endtask

    task initialize_pp1_dpp_buf1_as_input(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_dpp_temp1[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[0*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[1*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[2*4096 + 7*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 0*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 1*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 2*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 3*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 4*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 5*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 6*512 + _pp_idx];
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
        `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx]
            = _pp_dpp_temp1[3*4096 + 7*512 + _pp_idx];
        end
    endtask

// -------------------------------------
// preprocess Ping-pong buffer check
// -------------------------------------
logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_model_data [0:6*4096-1];
logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_model_data [0:4*4096-1];

    // -------------------------------------
    // check preprocess Ping-pong buffer tpp
    // -------------------------------------
    task check_pp0_tpp_buf0_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp0_tpp_buf1_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp0_tpp_buf2_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp1_tpp_buf0_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp1_tpp_buf1_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp1_tpp_buf2_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 24576; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_tpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_0.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_1.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_2.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_3.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_4.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[4*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_tpp_5.u_ram_2.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_tpp_model_data[5*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    // -------------------------------------
    // check preprocess Ping-pong buffer dpp
    // -------------------------------------
    task check_pp0_dpp_buf0_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_dpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp0_dpp_buf1_as_output(string filename);
        fp_r0 = $fopen(filename, "r");
        if (fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r0, "%h", _pp_dpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP0.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp1_dpp_buf0_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_dpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_0.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

    task check_pp1_dpp_buf1_as_output(string filename);
        fp_r1 = $fopen(filename, "r");
        if (fp_r1 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (_pp_idx = 0; _pp_idx < 16384; _pp_idx = _pp_idx + 1) begin
            flag = $fscanf(fp_r1, "%h", _pp_dpp_model_data[_pp_idx]);
        end

        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_0.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[0*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_1.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[1*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_2.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[2*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[0].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 0*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[1].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 1*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[2].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 2*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[3].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 3*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[4].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 4*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[5].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 5*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[6].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 6*512 + _pp_idx]
                );
                $finish;
            end
        end
        for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin
            if (`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx] ===
                _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]) begin
            end
            else begin
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $display("`PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\n",
                         _pp_idx,
                         `PP1.u_dpp_3.u_ram_1.u_ram.genblk1[7].base_bank.mem_bank[_pp_idx],
                         _pp_dpp_model_data[3*4096 + 7*512 + _pp_idx]
                );
                $finish;
            end
        end
    endtask

// ----------------------------------------
// reduce_trace buffer initialize and check
// ----------------------------------------
logic [COE_WIDTH-1:0] temp2;

    // -------------------------------------
    // reduce_trace Ping-pong buffer 1
    // -------------------------------------
    task initialize_rt_pp1_buf0_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf0_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf0_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf0_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf0_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf0_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf0_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf0.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g1[0].pp.buf0.init = 1;
        `RT.g1[1].pp.buf0.init = 1;
        `RT.g1[2].pp.buf0.init = 1;
        `RT.g1[3].pp.buf0.init = 1;
        `RT.g1[4].pp.buf0.init = 1;
        `RT.g1[5].pp.buf0.init = 1;
        wait_quarter_cycle();
        `RT.g1[0].pp.buf0.init = 0;
        `RT.g1[1].pp.buf0.init = 0;
        `RT.g1[2].pp.buf0.init = 0;
        `RT.g1[3].pp.buf0.init = 0;
        `RT.g1[4].pp.buf0.init = 0;
        `RT.g1[5].pp.buf0.init = 0;
    endtask

    task initialize_rt_pp1_buf0_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf0_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf0_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf0_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf0_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf0_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf0_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf0.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp1_buf0();
        `RT.g1[0].pp.buf0.check = 1;
        `RT.g1[1].pp.buf0.check = 1;
        `RT.g1[2].pp.buf0.check = 1;
        `RT.g1[3].pp.buf0.check = 1;
        `RT.g1[4].pp.buf0.check = 1;
        `RT.g1[5].pp.buf0.check = 1;
        wait_one_cycle();
        `RT.g1[0].pp.buf0.check = 0;
        `RT.g1[1].pp.buf0.check = 0;
        `RT.g1[2].pp.buf0.check = 0;
        `RT.g1[3].pp.buf0.check = 0;
        `RT.g1[4].pp.buf0.check = 0;
        `RT.g1[5].pp.buf0.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp1_buf1_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf1_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf1_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf1_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf1_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf1_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf1_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf1.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g1[0].pp.buf1.init = 1;
        `RT.g1[1].pp.buf1.init = 1;
        `RT.g1[2].pp.buf1.init = 1;
        `RT.g1[3].pp.buf1.init = 1;
        `RT.g1[4].pp.buf1.init = 1;
        `RT.g1[5].pp.buf1.init = 1;
        wait_quarter_cycle();
        `RT.g1[0].pp.buf1.init = 0;
        `RT.g1[1].pp.buf1.init = 0;
        `RT.g1[2].pp.buf1.init = 0;
        `RT.g1[3].pp.buf1.init = 0;
        `RT.g1[4].pp.buf1.init = 0;
        `RT.g1[5].pp.buf1.init = 0;
    endtask

    task initialize_rt_pp1_buf1_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf1_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf1_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf1_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf1_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf1_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf1_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf1.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp1_buf1();
        `RT.g1[0].pp.buf1.check = 1;
        `RT.g1[1].pp.buf1.check = 1;
        `RT.g1[2].pp.buf1.check = 1;
        `RT.g1[3].pp.buf1.check = 1;
        `RT.g1[4].pp.buf1.check = 1;
        `RT.g1[5].pp.buf1.check = 1;
        wait_one_cycle();
        `RT.g1[0].pp.buf1.check = 0;
        `RT.g1[1].pp.buf1.check = 0;
        `RT.g1[2].pp.buf1.check = 0;
        `RT.g1[3].pp.buf1.check = 0;
        `RT.g1[4].pp.buf1.check = 0;
        `RT.g1[5].pp.buf1.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp1_buf2_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf2_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf2_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf2_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf2_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf2_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf2_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf2.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g1[0].pp.buf2.init = 1;
        `RT.g1[1].pp.buf2.init = 1;
        `RT.g1[2].pp.buf2.init = 1;
        `RT.g1[3].pp.buf2.init = 1;
        `RT.g1[4].pp.buf2.init = 1;
        `RT.g1[5].pp.buf2.init = 1;
        wait_quarter_cycle();
        `RT.g1[0].pp.buf2.init = 0;
        `RT.g1[1].pp.buf2.init = 0;
        `RT.g1[2].pp.buf2.init = 0;
        `RT.g1[3].pp.buf2.init = 0;
        `RT.g1[4].pp.buf2.init = 0;
        `RT.g1[5].pp.buf2.init = 0;
    endtask

    task initialize_rt_pp1_buf2_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf2_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g1[0].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp1_buf2_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g1[1].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf2_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g1[2].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp1_buf2_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g1[3].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf2_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g1[4].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp1_buf2_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g1[5].pp.buf2.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp1_buf2();
        `RT.g1[0].pp.buf2.check = 1;
        `RT.g1[1].pp.buf2.check = 1;
        `RT.g1[2].pp.buf2.check = 1;
        `RT.g1[3].pp.buf2.check = 1;
        `RT.g1[4].pp.buf2.check = 1;
        `RT.g1[5].pp.buf2.check = 1;
        wait_one_cycle();
        `RT.g1[0].pp.buf2.check = 0;
        `RT.g1[1].pp.buf2.check = 0;
        `RT.g1[2].pp.buf2.check = 0;
        `RT.g1[3].pp.buf2.check = 0;
        `RT.g1[4].pp.buf2.check = 0;
        `RT.g1[5].pp.buf2.check = 0;
        wait_one_cycle();
    endtask


    // -------------------------------------
    // reduce_trace Ping-pong buffer 2
    // -------------------------------------
    task initialize_rt_pp2_buf0_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf0_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf0_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf0_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf0_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf0_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf0_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf0.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g2[0].pp.buf0.init = 1;
        `RT.g2[1].pp.buf0.init = 1;
        `RT.g2[2].pp.buf0.init = 1;
        `RT.g2[3].pp.buf0.init = 1;
        `RT.g2[4].pp.buf0.init = 1;
        `RT.g2[5].pp.buf0.init = 1;
        wait_quarter_cycle();
        `RT.g2[0].pp.buf0.init = 0;
        `RT.g2[1].pp.buf0.init = 0;
        `RT.g2[2].pp.buf0.init = 0;
        `RT.g2[3].pp.buf0.init = 0;
        `RT.g2[4].pp.buf0.init = 0;
        `RT.g2[5].pp.buf0.init = 0;
    endtask

    task initialize_rt_pp2_buf0_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf0_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf0_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf0_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf0_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf0_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf0_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf0.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp2_buf0();
        `RT.g2[0].pp.buf0.check = 1;
        `RT.g2[1].pp.buf0.check = 1;
        `RT.g2[2].pp.buf0.check = 1;
        `RT.g2[3].pp.buf0.check = 1;
        `RT.g2[4].pp.buf0.check = 1;
        `RT.g2[5].pp.buf0.check = 1;
        wait_one_cycle();
        `RT.g2[0].pp.buf0.check = 0;
        `RT.g2[1].pp.buf0.check = 0;
        `RT.g2[2].pp.buf0.check = 0;
        `RT.g2[3].pp.buf0.check = 0;
        `RT.g2[4].pp.buf0.check = 0;
        `RT.g2[5].pp.buf0.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp2_buf1_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf1_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf1_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf1_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf1_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf1_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf1_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf1.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g2[0].pp.buf1.init = 1;
        `RT.g2[1].pp.buf1.init = 1;
        `RT.g2[2].pp.buf1.init = 1;
        `RT.g2[3].pp.buf1.init = 1;
        `RT.g2[4].pp.buf1.init = 1;
        `RT.g2[5].pp.buf1.init = 1;
        wait_quarter_cycle();
        `RT.g2[0].pp.buf1.init = 0;
        `RT.g2[1].pp.buf1.init = 0;
        `RT.g2[2].pp.buf1.init = 0;
        `RT.g2[3].pp.buf1.init = 0;
        `RT.g2[4].pp.buf1.init = 0;
        `RT.g2[5].pp.buf1.init = 0;
    endtask

    task initialize_rt_pp2_buf1_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf1_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf1_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf1_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf1_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf1_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf1_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf1.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp2_buf1();
        `RT.g2[0].pp.buf1.check = 1;
        `RT.g2[1].pp.buf1.check = 1;
        `RT.g2[2].pp.buf1.check = 1;
        `RT.g2[3].pp.buf1.check = 1;
        `RT.g2[4].pp.buf1.check = 1;
        `RT.g2[5].pp.buf1.check = 1;
        wait_one_cycle();
        `RT.g2[0].pp.buf1.check = 0;
        `RT.g2[1].pp.buf1.check = 0;
        `RT.g2[2].pp.buf1.check = 0;
        `RT.g2[3].pp.buf1.check = 0;
        `RT.g2[4].pp.buf1.check = 0;
        `RT.g2[5].pp.buf1.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp2_buf2_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf2_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf2_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf2_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf2_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf2_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf2_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf2.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g2[0].pp.buf2.init = 1;
        `RT.g2[1].pp.buf2.init = 1;
        `RT.g2[2].pp.buf2.init = 1;
        `RT.g2[3].pp.buf2.init = 1;
        `RT.g2[4].pp.buf2.init = 1;
        `RT.g2[5].pp.buf2.init = 1;
        wait_quarter_cycle();
        `RT.g2[0].pp.buf2.init = 0;
        `RT.g2[1].pp.buf2.init = 0;
        `RT.g2[2].pp.buf2.init = 0;
        `RT.g2[3].pp.buf2.init = 0;
        `RT.g2[4].pp.buf2.init = 0;
        `RT.g2[5].pp.buf2.init = 0;
    endtask

    task initialize_rt_pp2_buf2_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf2_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g2[0].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp2_buf2_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g2[1].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf2_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g2[2].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp2_buf2_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g2[3].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf2_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g2[4].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < P) else $display("Assert Error: pp2_buf2_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g2[5].pp.buf2.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp2_buf2();
        `RT.g2[0].pp.buf2.check = 1;
        `RT.g2[1].pp.buf2.check = 1;
        `RT.g2[2].pp.buf2.check = 1;
        `RT.g2[3].pp.buf2.check = 1;
        `RT.g2[4].pp.buf2.check = 1;
        `RT.g2[5].pp.buf2.check = 1;
        wait_one_cycle();
        `RT.g2[0].pp.buf2.check = 0;
        `RT.g2[1].pp.buf2.check = 0;
        `RT.g2[2].pp.buf2.check = 0;
        `RT.g2[3].pp.buf2.check = 0;
        `RT.g2[4].pp.buf2.check = 0;
        `RT.g2[5].pp.buf2.check = 0;
        wait_one_cycle();
    endtask


    // -------------------------------------
    // reduce_trace Ping-pong buffer 3
    // -------------------------------------
    task initialize_rt_pp3_buf0_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf0.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf0.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g3[0].pp.buf0.init = 1;
        `RT.g3[1].pp.buf0.init = 1;
        `RT.g3[2].pp.buf0.init = 1;
        `RT.g3[3].pp.buf0.init = 1;
        `RT.g3[4].pp.buf0.init = 1;
        `RT.g3[5].pp.buf0.init = 1;
        wait_quarter_cycle();
        `RT.g3[0].pp.buf0.init = 0;
        `RT.g3[1].pp.buf0.init = 0;
        `RT.g3[2].pp.buf0.init = 0;
        `RT.g3[3].pp.buf0.init = 0;
        `RT.g3[4].pp.buf0.init = 0;
        `RT.g3[5].pp.buf0.init = 0;
    endtask

    task initialize_rt_pp3_buf0_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf0_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf0.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf0_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf0.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp3_buf0();
        `RT.g3[0].pp.buf0.check = 1;
        `RT.g3[1].pp.buf0.check = 1;
        `RT.g3[2].pp.buf0.check = 1;
        `RT.g3[3].pp.buf0.check = 1;
        `RT.g3[4].pp.buf0.check = 1;
        `RT.g3[5].pp.buf0.check = 1;
        wait_one_cycle();
        `RT.g3[0].pp.buf0.check = 0;
        `RT.g3[1].pp.buf0.check = 0;
        `RT.g3[2].pp.buf0.check = 0;
        `RT.g3[3].pp.buf0.check = 0;
        `RT.g3[4].pp.buf0.check = 0;
        `RT.g3[5].pp.buf0.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp3_buf1_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf1.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf1.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g3[0].pp.buf1.init = 1;
        `RT.g3[1].pp.buf1.init = 1;
        `RT.g3[2].pp.buf1.init = 1;
        `RT.g3[3].pp.buf1.init = 1;
        `RT.g3[4].pp.buf1.init = 1;
        `RT.g3[5].pp.buf1.init = 1;
        wait_quarter_cycle();
        `RT.g3[0].pp.buf1.init = 0;
        `RT.g3[1].pp.buf1.init = 0;
        `RT.g3[2].pp.buf1.init = 0;
        `RT.g3[3].pp.buf1.init = 0;
        `RT.g3[4].pp.buf1.init = 0;
        `RT.g3[5].pp.buf1.init = 0;
    endtask

    task initialize_rt_pp3_buf1_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf1_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf1.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf1_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf1.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp3_buf1();
        `RT.g3[0].pp.buf1.check = 1;
        `RT.g3[1].pp.buf1.check = 1;
        `RT.g3[2].pp.buf1.check = 1;
        `RT.g3[3].pp.buf1.check = 1;
        `RT.g3[4].pp.buf1.check = 1;
        `RT.g3[5].pp.buf1.check = 1;
        wait_one_cycle();
        `RT.g3[0].pp.buf1.check = 0;
        `RT.g3[1].pp.buf1.check = 0;
        `RT.g3[2].pp.buf1.check = 0;
        `RT.g3[3].pp.buf1.check = 0;
        `RT.g3[4].pp.buf1.check = 0;
        `RT.g3[5].pp.buf1.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp3_buf2_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf2.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf2.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g3[0].pp.buf2.init = 1;
        `RT.g3[1].pp.buf2.init = 1;
        `RT.g3[2].pp.buf2.init = 1;
        `RT.g3[3].pp.buf2.init = 1;
        `RT.g3[4].pp.buf2.init = 1;
        `RT.g3[5].pp.buf2.init = 1;
        wait_quarter_cycle();
        `RT.g3[0].pp.buf2.init = 0;
        `RT.g3[1].pp.buf2.init = 0;
        `RT.g3[2].pp.buf2.init = 0;
        `RT.g3[3].pp.buf2.init = 0;
        `RT.g3[4].pp.buf2.init = 0;
        `RT.g3[5].pp.buf2.init = 0;
    endtask

    task initialize_rt_pp3_buf2_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf2_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf2.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf2_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf2.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp3_buf2();
        `RT.g3[0].pp.buf2.check = 1;
        `RT.g3[1].pp.buf2.check = 1;
        `RT.g3[2].pp.buf2.check = 1;
        `RT.g3[3].pp.buf2.check = 1;
        `RT.g3[4].pp.buf2.check = 1;
        `RT.g3[5].pp.buf2.check = 1;
        wait_one_cycle();
        `RT.g3[0].pp.buf2.check = 0;
        `RT.g3[1].pp.buf2.check = 0;
        `RT.g3[2].pp.buf2.check = 0;
        `RT.g3[3].pp.buf2.check = 0;
        `RT.g3[4].pp.buf2.check = 0;
        `RT.g3[5].pp.buf2.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp3_buf3_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf3.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf3.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf3.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf3.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf3.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf3.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g3[0].pp.buf3.init = 1;
        `RT.g3[1].pp.buf3.init = 1;
        `RT.g3[2].pp.buf3.init = 1;
        `RT.g3[3].pp.buf3.init = 1;
        `RT.g3[4].pp.buf3.init = 1;
        `RT.g3[5].pp.buf3.init = 1;
        wait_quarter_cycle();
        `RT.g3[0].pp.buf3.init = 0;
        `RT.g3[1].pp.buf3.init = 0;
        `RT.g3[2].pp.buf3.init = 0;
        `RT.g3[3].pp.buf3.init = 0;
        `RT.g3[4].pp.buf3.init = 0;
        `RT.g3[5].pp.buf3.init = 0;
    endtask

    task initialize_rt_pp3_buf3_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf3.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf3.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf3.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf3.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf3_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf3.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf3_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf3.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp3_buf3();
        `RT.g3[0].pp.buf3.check = 1;
        `RT.g3[1].pp.buf3.check = 1;
        `RT.g3[2].pp.buf3.check = 1;
        `RT.g3[3].pp.buf3.check = 1;
        `RT.g3[4].pp.buf3.check = 1;
        `RT.g3[5].pp.buf3.check = 1;
        wait_one_cycle();
        `RT.g3[0].pp.buf3.check = 0;
        `RT.g3[1].pp.buf3.check = 0;
        `RT.g3[2].pp.buf3.check = 0;
        `RT.g3[3].pp.buf3.check = 0;
        `RT.g3[4].pp.buf3.check = 0;
        `RT.g3[5].pp.buf3.check = 0;
        wait_one_cycle();
    endtask


    task initialize_rt_pp3_buf4_as_input(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_input[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf4.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_input[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf4.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_input[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf4.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_input[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf4.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_input[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf4.temp_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_input[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf4.temp_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
        `RT.g3[0].pp.buf4.init = 1;
        `RT.g3[1].pp.buf4.init = 1;
        `RT.g3[2].pp.buf4.init = 1;
        `RT.g3[3].pp.buf4.init = 1;
        `RT.g3[4].pp.buf4.init = 1;
        `RT.g3[5].pp.buf4.init = 1;
        wait_quarter_cycle();
        `RT.g3[0].pp.buf4.init = 0;
        `RT.g3[1].pp.buf4.init = 0;
        `RT.g3[2].pp.buf4.init = 0;
        `RT.g3[3].pp.buf4.init = 0;
        `RT.g3[4].pp.buf4.init = 0;
        `RT.g3[5].pp.buf4.init = 0;
    endtask

    task initialize_rt_pp3_buf4_as_output(string filename);
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_output[0], addr = %d, data = %h\n", i, temp2);
            `RT.g3[0].pp.buf4.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_output[1], addr = %d, data = %h\n", i, temp2);
            `RT.g3[1].pp.buf4.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_output[2], addr = %d, data = %h\n", i, temp2);
            `RT.g3[2].pp.buf4.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_output[3], addr = %d, data = %h\n", i, temp2);
            `RT.g3[3].pp.buf4.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q0) else $display("Assert Error: pp3_buf4_as_output[4], addr = %d, data = %h\n", i, temp2);
            `RT.g3[4].pp.buf4.gold_mem[i] = temp2;
        end
        for (i = 0; i < POLY_SIZE; i++) begin
            rt = $fscanf(fd, "%h", temp2);
            assert(temp2 < Q1) else $display("Assert Error: pp3_buf4_as_output[5], addr = %d, data = %h\n", i, temp2);
            `RT.g3[5].pp.buf4.gold_mem[i] = temp2;
        end
        $fclose(fd);
        wait_quarter_cycle();
    endtask

    task check_rt_pp3_buf4();
        `RT.g3[0].pp.buf4.check = 1;
        `RT.g3[1].pp.buf4.check = 1;
        `RT.g3[2].pp.buf4.check = 1;
        `RT.g3[3].pp.buf4.check = 1;
        `RT.g3[4].pp.buf4.check = 1;
        `RT.g3[5].pp.buf4.check = 1;
        wait_one_cycle();
        `RT.g3[0].pp.buf4.check = 0;
        `RT.g3[1].pp.buf4.check = 0;
        `RT.g3[2].pp.buf4.check = 0;
        `RT.g3[3].pp.buf4.check = 0;
        `RT.g3[4].pp.buf4.check = 0;
        `RT.g3[5].pp.buf4.check = 0;
        wait_one_cycle();
    endtask


    // -------------------------------------
    // Reduce buffer init for stage 8 test
    // -------------------------------------
    logic [RB_PP_COE_WIDTH-1:0] _rb_temp;
    task initialize_reduce_buffer(string filename);
        fp_r0 = $fopen(filename, "r");
        if(fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end


        for(i = 0; i < POLY_SIZE; i = i + 1) begin
            flag = $fscanf(fp_r0, "%h", _rb_temp);
            `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] = _rb_temp;
        end


        for(i = 0; i < POLY_SIZE; i = i + 1) begin
            flag = $fscanf(fp_r0, "%h", _rb_temp);
            `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] = _rb_temp;
        end


        for(i = 0; i < POLY_SIZE; i = i + 1) begin
            flag = $fscanf(fp_r0, "%h", _rb_temp);
            `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] = _rb_temp;
        end


        for(i = 0; i < POLY_SIZE; i = i + 1) begin
            flag = $fscanf(fp_r0, "%h", _rb_temp);
            `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] = _rb_temp;
        end


    endtask
    // -------------------------------------
    // Reduce buffer check
    // -------------------------------------
    task check_reduce_buffer(string filename);
        fp_r0 = $fopen(filename, "r");
        if(fp_r0 == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end


        if(rt_buffer_wr_index === 0) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[0].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[0].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[0].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[0].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[0].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[0].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[0].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[0].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 1) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[1].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[1].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[1].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[1].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[1].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[1].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[1].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[1].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[1].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 2) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[2].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[2].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[2].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[2].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[2].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[2].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[2].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[2].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[2].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 3) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[3].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[3].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[3].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[3].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[3].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[3].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[3].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[3].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[3].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 4) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[4].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[4].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[4].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[4].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[4].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[4].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[4].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[4].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[4].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 5) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[5].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[5].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[5].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[5].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[5].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[5].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[5].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[5].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[5].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 6) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[6].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[6].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[6].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[6].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[6].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[6].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[6].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[6].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[6].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 7) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[7].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[7].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[7].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[7].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[7].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[7].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[7].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[7].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[7].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 8) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[8].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[8].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[8].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[8].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[8].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[8].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[8].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[8].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[8].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 9) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[9].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[9].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[9].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[9].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[9].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[9].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[9].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[9].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[9].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 10) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[10].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[10].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[10].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[10].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[10].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[10].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[10].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[10].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[10].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


        if(rt_buffer_wr_index === 11) begin
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[11].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[11].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[11].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[11].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[11].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $display("`RB.genblk1[11].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);
                    $finish;
                end
            end
            for(i = 0; i < POLY_SIZE; i = i + 1) begin
                flag = $fscanf(fp_r0, "%h", _rb_temp);
                if(`RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)
                begin
                end
                else begin
                    $display("`RB.genblk1[11].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $display("`RB.genblk1[11].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\n", i, `RB.genblk1[11].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);
                    $finish;
                end
            end
        end


    endtask
    // -------------------------------------
    // KSK URAM check
    // -------------------------------------
    task check_ksk_uram;
        fd = $fopen({RUN_DIR, "vcs/", "uram_k0.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k0.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[0].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[0].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[0].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[0].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[0].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k1.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k1.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[1].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[1].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[1].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[1].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[1].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k2.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k2.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[2].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[2].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[2].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[2].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[2].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k3.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k3.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[3].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[3].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[3].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[3].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[3].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k4.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k4.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[4].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[4].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[4].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[4].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[4].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k5.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k5.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[5].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[5].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[5].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[5].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[5].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k6.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k6.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[6].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[6].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[6].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[6].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[6].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k7.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k7.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[7].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[7].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[7].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[7].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[7].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k8.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k8.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[8].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[8].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[8].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[8].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[8].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k9.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k9.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[9].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[9].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[9].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[9].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[9].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k10.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k10.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[10].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[10].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[10].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[10].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[10].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


        fd = $fopen({RUN_DIR, "vcs/", "uram_k11.mem"}, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file uram_k11.mem ! \n");
            $finish;
        end
        for(i = 0; i < 6144; i = i + 1) begin
            rt = $fscanf(fd, "%h", ksk_mem);
            if(gen_ksk_model[11].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)
            begin
            end
            else begin
                $display("gen_ksk_model[11].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i,gen_ksk_model[11].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $display("gen_ksk_model[11].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i,gen_ksk_model[11].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);
                $finish;
            end
        end


    endtask



