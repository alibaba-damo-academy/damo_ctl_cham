bit [2:0] rt_lower_state, rt_upper_state;
bit [1:0] dp_tri_mode;
bit [1:0] pp_tpp_mode;
bit       pp_dpp_mode;

initial begin
    force rt_lower_state = `RT.g1[0].pp.state;
    force rt_upper_state = `RT.g3[0].pp.state;
    force dp_tri_mode    = `DP.tri_pp0.mode;
    force pp_tpp_mode    = `PP0.u_tpp_0.state;
    force pp_dpp_mode    = `PP0.u_dpp_0.state;
end 
    // -------------------------------------
    // Initialize input mem
    // -------------------------------------
    always @(posedge stage_start_partial_test_pre[0]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input ddr mem of stage-0\n");
            initialize_ddr_mem_partial({test_data_dir, "ddr_in_partial.txt"}, {test_data_dir, "ddr_in_ksk.txt"});
        end
    end

    always @(posedge stage_start_partial_test_pre[1]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input mem of stage-1\n");
            if(dp_tri_mode == 0) begin
                //$display(" -- buf1");
                initialize_dp_tri_pp0_buf1_as_input({test_data_dir, "stg1_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf1_as_input({test_data_dir, "stg1_b_in_x3.txt"});
            end
            else if(dp_tri_mode == 1) begin
                //$display(" -- buf0");
                initialize_dp_tri_pp0_buf0_as_input({test_data_dir, "stg1_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf0_as_input({test_data_dir, "stg1_b_in_x3.txt"});
            end
            else begin
                //$display(" -- buf2");
                initialize_dp_tri_pp0_buf2_as_input({test_data_dir, "stg1_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf2_as_input({test_data_dir, "stg1_b_in_x3.txt"});
            end
        end
    end

    always @(posedge stage_start_partial_test_pre[2]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input mem of stage-2\n");
            if(dp_tri_mode == 0) begin
                //$display(" -- buf2");
                initialize_dp_tri_pp0_buf2_as_input({test_data_dir, "stg2_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf2_as_input({test_data_dir, "stg2_b_in_x3.txt"});
            end
            else if(dp_tri_mode == 1) begin
                //$display(" -- buf1");
                initialize_dp_tri_pp0_buf1_as_input({test_data_dir, "stg2_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf1_as_input({test_data_dir, "stg2_b_in_x3.txt"});
            end
            else begin
                //$display(" -- buf0");
                initialize_dp_tri_pp0_buf0_as_input({test_data_dir, "stg2_a_in_x3.txt"});
                initialize_dp_tri_pp1_buf0_as_input({test_data_dir, "stg2_b_in_x3.txt"});
            end

            initialize_dp_ctxt_uram("uram_vec.mem", 1);
        end
    end

    always @ (posedge stage_start_partial_test_pre[3]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input mem of stage-3\n");
            if(pp_tpp_mode == 0) begin
                //$display(" -- buf0");
                initialize_pp0_tpp_buf1_as_input({test_data_dir, "stg3_a_in_x6.txt"});
                initialize_pp1_tpp_buf1_as_input({test_data_dir, "stg3_b_in_x6.txt"});
            end
            else if(pp_tpp_mode == 1) begin
                //$display(" -- buf1");
                initialize_pp0_tpp_buf0_as_input({test_data_dir, "stg3_a_in_x6.txt"});
                initialize_pp1_tpp_buf0_as_input({test_data_dir, "stg3_b_in_x6.txt"});
            end
            else begin
                //$display(" -- buf2");
                initialize_pp0_tpp_buf2_as_input({test_data_dir, "stg3_a_in_x6.txt"});
                initialize_pp1_tpp_buf2_as_input({test_data_dir, "stg3_b_in_x6.txt"});
            end
        end
    end

    always @ (posedge stage_start_partial_test_pre[4]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input mem of stage-4\n");
            if(pp_tpp_mode == 0) begin
                //$display(" -- buf2");
                initialize_pp0_tpp_buf2_as_input({test_data_dir, "stg4_a_in_x6.txt"});
                initialize_pp1_tpp_buf2_as_input({test_data_dir, "stg4_b_in_x6.txt"});
            end
            else if(pp_tpp_mode == 1) begin
                //$display(" -- buf1");
                initialize_pp0_tpp_buf1_as_input({test_data_dir, "stg4_a_in_x6.txt"});
                initialize_pp1_tpp_buf1_as_input({test_data_dir, "stg4_b_in_x6.txt"});
            end
            else begin
                //$display(" -- buf0");
                initialize_pp0_tpp_buf0_as_input({test_data_dir, "stg4_a_in_x6.txt"});
                initialize_pp1_tpp_buf0_as_input({test_data_dir, "stg4_b_in_x6.txt"});
            end
        end
    end

    always @(posedge stage_start_partial_test_pre[5]) begin //TODO: fix stage 3 input
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input lower RAM of stage-5\n");
            if (pp_dpp_mode) begin
                initialize_pp0_dpp_buf0_as_input({test_data_dir, "stg4_a_out_x4.txt"});
                initialize_pp1_dpp_buf0_as_input({test_data_dir, "stg4_b_out_x4.txt"});
            end
            else begin
                initialize_pp0_dpp_buf1_as_input({test_data_dir, "stg4_a_out_x4.txt"});
                initialize_pp1_dpp_buf1_as_input({test_data_dir, "stg4_b_out_x4.txt"});
            end
        end
    end

    //always @(posedge stage_start_partial_test_pre[4]) begin //no need to initialize or check upper data for stage 4, 5, 6
    //    if (DEBUG_SINGLE_STAGE) begin
    //        $display("\nInitialize input upper RAM of stage-4\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf3");
    //            initialize_rt_pp3_buf3_as_input({test_data_dir, "stg4_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf4");
    //            initialize_rt_pp3_buf4_as_input({test_data_dir, "stg4_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf0");
    //            initialize_rt_pp3_buf0_as_input({test_data_dir, "stg4_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf1");
    //            initialize_rt_pp3_buf1_as_input({test_data_dir, "stg4_in_upper_x6.txt"});
    //        end
    //        else begin
    //            $display(" -- buf2");
    //            initialize_rt_pp3_buf2_as_input({test_data_dir, "stg4_in_upper_x6.txt"});
    //        end
    //    end
    //end

    always @(posedge stage_start_partial_test_pre[6]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input lower RAM of stage-6\n");
            if (rt_lower_state == 0) begin
                //$display(" -- pp1 buf1");
                initialize_rt_pp1_buf1_as_input({test_data_dir, "stg6_in_lower_x6.txt"});
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp1 buf0");
                initialize_rt_pp1_buf0_as_input({test_data_dir, "stg6_in_lower_x6.txt"});
            end
            else begin
                //$display(" -- pp1 buf2");
                initialize_rt_pp1_buf2_as_input({test_data_dir, "stg6_in_lower_x6.txt"});
            end
        end
    end

    //always @(posedge stage_start_partial_test_pre[5]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    if (DEBUG_SINGLE_STAGE) begin
    //        $display("\nInitialize input upper RAM of stage-5\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf2");
    //            initialize_rt_pp3_buf2_as_input({test_data_dir, "stg5_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf3");
    //            initialize_rt_pp3_buf3_as_input({test_data_dir, "stg5_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf4");
    //            initialize_rt_pp3_buf4_as_input({test_data_dir, "stg5_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf0");
    //            initialize_rt_pp3_buf0_as_input({test_data_dir, "stg5_in_upper_x6.txt"});
    //        end
    //        else begin
    //            $display(" -- buf1");
    //            initialize_rt_pp3_buf1_as_input({test_data_dir, "stg5_in_upper_x6.txt"});
    //        end
    //    end
    //end

    always @(posedge stage_start_partial_test_pre[7]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input lower RAM of stage-7\n");
            if (rt_lower_state == 0) begin
                //$display(" -- pp1 buf2");
                initialize_rt_pp1_buf2_as_input({test_data_dir, "stg7_in_lower_x6.txt"});
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp1 buf1");
                initialize_rt_pp1_buf1_as_input({test_data_dir, "stg7_in_lower_x6.txt"});
            end
            else begin
                //$display(" -- pp1 buf0");
                initialize_rt_pp1_buf0_as_input({test_data_dir, "stg7_in_lower_x6.txt"});
            end
        end
    end

    //always @(posedge stage_start_partial_test_pre[6]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    if (DEBUG_SINGLE_STAGE) begin
    //        $display("\nInitialize input upper RAM of stage-6\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf1");
    //            initialize_rt_pp3_buf1_as_input({test_data_dir, "stg6_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf2");
    //            initialize_rt_pp3_buf2_as_input({test_data_dir, "stg6_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf3");
    //            initialize_rt_pp3_buf3_as_input({test_data_dir, "stg6_in_upper_x6.txt"});
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf4");
    //            initialize_rt_pp3_buf4_as_input({test_data_dir, "stg6_in_upper_x6.txt"});
    //        end
    //        else begin
    //            $display(" -- buf0");
    //            initialize_rt_pp3_buf0_as_input({test_data_dir, "stg6_in_upper_x6.txt"});
    //        end
    //    end
    //end

    always @(posedge stage_start_partial_test_pre[8]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input lower RAM of stage-8\n");
            if (rt_lower_state == 0) begin
                //$display(" -- pp2 buf1");
                initialize_rt_pp2_buf1_as_input({test_data_dir, "stg8_in_lower_x6.txt"});
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp2 buf0");
                initialize_rt_pp2_buf0_as_input({test_data_dir, "stg8_in_lower_x6.txt"});
            end
            else begin
                //$display(" -- pp2 buf2");
                initialize_rt_pp2_buf2_as_input({test_data_dir, "stg8_in_lower_x6.txt"});
            end
        end
    end

    always @(posedge stage_start_partial_test_pre[9]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input upper RAM of stage-9\n");
            if (rt_upper_state == 0) begin
                //$display(" -- buf0");
                initialize_rt_pp3_buf0_as_input({test_data_dir, "stg9_in_upper_x6.txt"});
            end
            else if (rt_upper_state == 1) begin
                //$display(" -- buf1");
                initialize_rt_pp3_buf1_as_input({test_data_dir, "stg9_in_upper_x6.txt"});
            end
            else if (rt_upper_state == 2) begin
                //$display(" -- buf2");
                initialize_rt_pp3_buf2_as_input({test_data_dir, "stg9_in_upper_x6.txt"});
            end
            else if (rt_upper_state == 3) begin
                //$display(" -- buf3");
                initialize_rt_pp3_buf3_as_input({test_data_dir, "stg9_in_upper_x6.txt"});
            end
            else begin
                //$display(" -- buf4");
                initialize_rt_pp3_buf4_as_input({test_data_dir, "stg9_in_upper_x6.txt"});
            end
        end
    end

    always @(posedge stage_start_partial_test_pre[9]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input lower RAM of stage-9\n");
            if (rt_lower_state == 0) begin
                //$display(" -- pp2 buf2");
                initialize_rt_pp2_buf2_as_input({test_data_dir, "stg9_in_lower_x6.txt"});
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp2 buf1");
                initialize_rt_pp2_buf1_as_input({test_data_dir, "stg9_in_lower_x6.txt"});
            end
            else begin
                //$display(" -- pp2 buf0");
                initialize_rt_pp2_buf0_as_input({test_data_dir, "stg9_in_lower_x6.txt"});
            end
        end
    end

    always @(posedge stage_start_partial_test_pre[10]) begin
        if (DEBUG_SINGLE_STAGE) begin
            $display("\nInitialize input (ReduceBuffer) of stage-10\n");
            initialize_reduce_buffer({test_data_dir, "stg10_in_x4.txt"});
        end
    end



    // -------------------------------------
    // Initialize output mem
    // -------------------------------------

    always @(posedge stage_start_d7[5]) begin
        //$display("\nInitialize output upper RAM of stage-5\n");
        if (rt_upper_state == 0) begin
            //$display(" -- buf4");
            initialize_rt_pp3_buf4_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
        end
        else if (rt_upper_state == 1) begin
            //$display(" -- buf0");
            initialize_rt_pp3_buf0_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
        end
        else if (rt_upper_state == 2) begin
            //$display(" -- buf1");
            initialize_rt_pp3_buf1_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
        end
        else if (rt_upper_state == 3) begin
            //$display(" -- buf2");
            initialize_rt_pp3_buf2_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
        end
        else begin
            //$display(" -- buf3");
            initialize_rt_pp3_buf3_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
        end
    end

    always @(posedge stage_start_d7[5]) begin
        //$display("\nInitialize output lower RAM of stage-5\n");
        if (rt_lower_state == 0) begin
            //$display(" -- pp1 buf0");
            initialize_rt_pp1_buf0_as_output({test_data_dir, "stg5_out_lower_x6.txt"});
        end
        else if (rt_lower_state == 1) begin
            //$display(" -- pp1 buf2");
            initialize_rt_pp1_buf2_as_output({test_data_dir, "stg5_out_lower_x6.txt"});
        end
        else begin
            //$display(" -- pp1 buf1");
            initialize_rt_pp1_buf1_as_output({test_data_dir, "stg5_out_lower_x6.txt"});
        end
    end

    //always @(posedge stage_start_d7[4]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    $display("\nInitialize output upper RAM of stage-4\n");
    //    if (rt_upper_state == 0) begin
    //        $display(" -- buf3");
    //        initialize_rt_pp3_buf3_as_output({test_data_dir, "stg4_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 1) begin
    //        $display(" -- buf4");
    //        initialize_rt_pp3_buf4_as_output({test_data_dir, "stg4_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 2) begin
    //        $display(" -- buf0");
    //        initialize_rt_pp3_buf0_as_output({test_data_dir, "stg4_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 3) begin
    //        $display(" -- buf1");
    //        initialize_rt_pp3_buf1_as_output({test_data_dir, "stg4_out_upper_x6.txt"});
    //    end
    //    else begin
    //        $display(" -- buf2");
    //        initialize_rt_pp3_buf2_as_output({test_data_dir, "stg4_out_upper_x6.txt"});
    //    end
    //end

    always @(posedge stage_start_d7[6]) begin
        //$display("\nInitialize output lower RAM of stage-6\n");
        if (rt_lower_state == 0) begin
            //$display(" -- pp1 buf1");
            initialize_rt_pp1_buf1_as_output({test_data_dir, "stg6_out_lower_x6.txt"});
        end
        else if (rt_lower_state == 1) begin
            //$display(" -- pp1 buf0");
            initialize_rt_pp1_buf0_as_output({test_data_dir, "stg6_out_lower_x6.txt"});
        end
        else begin
            //$display(" -- pp1 buf2");
            initialize_rt_pp1_buf2_as_output({test_data_dir, "stg6_out_lower_x6.txt"});
        end
    end

    //always @(posedge stage_start_d7[5]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    $display("\nInitialize output upper RAM of stage-5\n");
    //    if (rt_upper_state == 0) begin
    //        $display(" -- buf2");
    //        initialize_rt_pp3_buf2_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 1) begin
    //        $display(" -- buf3");
    //        initialize_rt_pp3_buf3_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 2) begin
    //        $display(" -- buf4");
    //        initialize_rt_pp3_buf4_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 3) begin
    //        $display(" -- buf0");
    //        initialize_rt_pp3_buf0_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
    //    end
    //    else begin
    //        $display(" -- buf1");
    //        initialize_rt_pp3_buf1_as_output({test_data_dir, "stg5_out_upper_x6.txt"});
    //    end
    //end

    always @(posedge stage_start_d7[7]) begin
        //$display("\nInitialize output lower RAM of stage-7\n");
        if (rt_lower_state == 0) begin
            //$display(" -- pp2 buf0");
            initialize_rt_pp2_buf0_as_output({test_data_dir, "stg7_out_lower_x6.txt"});
        end
        else if (rt_lower_state == 1) begin
            //$display(" -- pp2 buf2");
            initialize_rt_pp2_buf2_as_output({test_data_dir, "stg7_out_lower_x6.txt"});
        end
        else begin
            //$display(" -- pp2 buf1");
            initialize_rt_pp2_buf1_as_output({test_data_dir, "stg7_out_lower_x6.txt"});
        end
    end

    //always @(posedge stage_start_d7[6]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    $display("\nInitialize output upper RAM of stage-6\n");
    //    if (rt_upper_state == 0) begin
    //        $display(" -- buf1");
    //        initialize_rt_pp3_buf1_as_output({test_data_dir, "stg6_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 1) begin
    //        $display(" -- buf2");
    //        initialize_rt_pp3_buf2_as_output({test_data_dir, "stg6_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 2) begin
    //        $display(" -- buf3");
    //        initialize_rt_pp3_buf3_as_output({test_data_dir, "stg6_out_upper_x6.txt"});
    //    end
    //    else if (rt_upper_state == 3) begin
    //        $display(" -- buf4");
    //        initialize_rt_pp3_buf4_as_output({test_data_dir, "stg6_out_upper_x6.txt"});
    //    end
    //    else begin
    //        $display(" -- buf0");
    //        initialize_rt_pp3_buf0_as_output({test_data_dir, "stg6_out_upper_x6.txt"});
    //    end
    //end

    always @(posedge stage_start_d7[8]) begin
        //$display("\nInitialize output lower RAM of stage-8\n");
        if (rt_lower_state == 0) begin
            //$display(" -- pp2 buf1");
            initialize_rt_pp2_buf1_as_output({test_data_dir, "stg8_out_lower_x6.txt"});
        end
        else if (rt_lower_state == 1) begin
            //$display(" -- pp2 buf0");
            initialize_rt_pp2_buf0_as_output({test_data_dir, "stg8_out_lower_x6.txt"});
        end
        else begin
            //$display(" -- pp2 buf2");
            initialize_rt_pp2_buf2_as_output({test_data_dir, "stg8_out_lower_x6.txt"});
        end
    end


    // -------------------------------------
    // Check output mem
    // -------------------------------------
    always @(posedge interrupt) begin
        if (!stage0_mode) begin
    //always @(posedge stage_done[0]) begin
    //    if (stage_status[0] && (!stage0_mode)) begin
            $display("\nCheck timeslot %d output of stage-0_0\n", ts);
            //$display(" -- ksk ram");
            check_ksk_uram();
        end
    end

    always @(posedge stage_done[0]) begin
        if (stage_status[0] && stage0_mode) begin
            $display("\nCheck timeslot %d output of stage-0_1\n", ts);
            if (dp_tri_mode == 0) begin
                //$display(" -- dp0 buf0");
                check_dp_tri_pp0_buf0_as_output({test_data_dir, "stg0_a_out_x3.txt"});
                //$display(" -- dp1 buf0");
                check_dp_tri_pp1_buf0_as_output({test_data_dir, "stg0_b_out_x3.txt"});
            end
            else if (dp_tri_mode == 1) begin
                //$display(" -- dp0 buf2");
                check_dp_tri_pp0_buf2_as_output({test_data_dir, "stg0_a_out_x3.txt"});
                //$display(" -- dp1 buf2");
                check_dp_tri_pp1_buf2_as_output({test_data_dir, "stg0_b_out_x3.txt"});
            end
            else begin
                //$display(" -- dp0 buf1");
                check_dp_tri_pp0_buf1_as_output({test_data_dir, "stg0_a_out_x3.txt"});
                //$display(" -- dp1 buf1");
                check_dp_tri_pp1_buf1_as_output({test_data_dir, "stg0_b_out_x3.txt"});
            end
        end
    end

    always @(posedge stage_done[1]) begin
        if (stage_status[1]) begin
            $display("\nCheck timeslot %d output of stage-1\n", ts);
            if (dp_tri_mode == 0) begin
                //$display(" -- dp0 buf1");
                check_dp_tri_pp0_buf1_as_output({test_data_dir, "stg1_a_out_x3.txt"});
                //$display(" -- dp1 buf1");
                check_dp_tri_pp1_buf1_as_output({test_data_dir, "stg1_b_out_x3.txt"});
            end
            else if (dp_tri_mode == 1) begin
                //$display(" -- dp0 buf0");
                check_dp_tri_pp0_buf0_as_output({test_data_dir, "stg1_a_out_x3.txt"});
                //$display(" -- dp1 buf0");
                check_dp_tri_pp1_buf0_as_output({test_data_dir, "stg1_b_out_x3.txt"});
            end
            else begin
                //$display(" -- dp0 buf2");
                check_dp_tri_pp0_buf2_as_output({test_data_dir, "stg1_a_out_x3.txt"});
                //$display(" -- dp1 buf2");
                check_dp_tri_pp1_buf2_as_output({test_data_dir, "stg1_b_out_x3.txt"});
            end
        end
    end

    always @(posedge stage_done[2]) begin
        if (stage_status[2]) begin
            $display("\nCheck timeslot %d output of stage-2\n", ts);
            if (pp_tpp_mode == 0) begin
                //$display(" -- pp0 buf0");
                check_pp0_tpp_buf0_as_output({test_data_dir, "stg2_a_out_x6.txt"});
                //$display(" -- pp1 buf0");
                check_pp1_tpp_buf0_as_output({test_data_dir, "stg2_b_out_x6.txt"});
            end
            else if (pp_tpp_mode == 1) begin
                //$display(" -- pp0 buf2");
                check_pp0_tpp_buf2_as_output({test_data_dir, "stg2_a_out_x6.txt"});
                //$display(" -- pp1 buf2");
                check_pp1_tpp_buf2_as_output({test_data_dir, "stg2_b_out_x6.txt"});
            end
            else begin
                //$display(" -- pp0 buf1");
                check_pp0_tpp_buf1_as_output({test_data_dir, "stg2_a_out_x6.txt"});
                //$display(" -- pp1 buf1");
                check_pp1_tpp_buf1_as_output({test_data_dir, "stg2_b_out_x6.txt"});
            end
        end
    end

    always @(posedge stage_done[3]) begin
        if (stage_status[3]) begin
            $display("\nCheck timeslot %d output of stage-3\n", ts);
            if (pp_tpp_mode == 0) begin
                //$display(" -- pp0 buf1");
                check_pp0_tpp_buf1_as_output({test_data_dir, "stg3_a_out_x6.txt"});
                //$display(" -- pp1 buf1");
                check_pp1_tpp_buf1_as_output({test_data_dir, "stg3_b_out_x6.txt"});
            end
            else if (pp_tpp_mode == 1) begin
                //$display(" -- pp0 buf0");
                check_pp0_tpp_buf0_as_output({test_data_dir, "stg3_a_out_x6.txt"});
                //$display(" -- pp1 buf0");
                check_pp1_tpp_buf0_as_output({test_data_dir, "stg3_b_out_x6.txt"});
            end
            else begin
                //$display(" -- pp0 buf2");
                check_pp0_tpp_buf2_as_output({test_data_dir, "stg3_a_out_x6.txt"});
                //$display(" -- pp1 buf2");
                check_pp1_tpp_buf2_as_output({test_data_dir, "stg3_b_out_x6.txt"});
            end
        end
    end

    always @(posedge stage_done[4]) begin
        if (stage_status[4]) begin
            $display("\nCheck timeslot %d output of stage-4\n", ts);
            if (pp_dpp_mode == 0) begin
                //$display(" -- pp0 buf0");
                check_pp0_dpp_buf0_as_output({test_data_dir, "stg4_a_out_x4.txt"});
                //$display(" -- pp1 buf0");
                check_pp1_dpp_buf0_as_output({test_data_dir, "stg4_b_out_x4.txt"});
            end
            else begin
                //$display(" -- pp0 buf1");
                check_pp0_dpp_buf1_as_output({test_data_dir, "stg4_a_out_x4.txt"});
                //$display(" -- pp1 buf1");
                check_pp1_dpp_buf1_as_output({test_data_dir, "stg4_b_out_x4.txt"});
            end
        end
    end


    always @(posedge stage_done[5]) begin
        if (stage_status[5]) begin
            $display("\nCheck timeslot %d output upper RAM of stage-5\n", ts);
            if (rt_upper_state == 0) begin
                //$display(" -- buf4");
                check_rt_pp3_buf4();
            end
            else if (rt_upper_state == 1) begin
                //$display(" -- buf0");
                check_rt_pp3_buf0();
            end
            else if (rt_upper_state == 2) begin
                //$display(" -- buf1");
                check_rt_pp3_buf1();
            end
            else if (rt_upper_state == 3) begin
                //$display(" -- buf2");
                check_rt_pp3_buf2();
            end
            else begin
                //$display(" -- buf3");
                check_rt_pp3_buf3();
            end
        end
    end

    always @(posedge stage_done[5]) begin
        if (stage_status[5]) begin
            $display("\nCheck timeslot %d output lower RAM of stage-5\n", ts);
            if (rt_lower_state == 0) begin
                //$display(" -- pp1 buf0");
                check_rt_pp1_buf0();
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp1 buf2");
                check_rt_pp1_buf2();
            end
            else begin
                //$display(" -- pp1 buf1");
                check_rt_pp1_buf1();
            end
        end
    end

    //always @(posedge stage_done[4]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    if (stage_status[4]) begin
    //        $display("\nCheck output upper RAM of stage-4\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf3");
    //            check_rt_pp3_buf3();
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf4");
    //            check_rt_pp3_buf4();
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf0");
    //            check_rt_pp3_buf0();
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf1");
    //            check_rt_pp3_buf1();
    //        end
    //        else begin
    //            $display(" -- buf2");
    //            check_rt_pp3_buf2();
    //        end
    //    end
    //end

    always @(posedge stage_done[6]) begin
        if (stage_status[6]) begin
            $display("\nCheck timeslot %d output lower RAM of stage-6\n", ts);
            if (rt_lower_state == 0) begin
                //$display(" -- pp1 buf1");
                check_rt_pp1_buf1();
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp1 buf0");
                check_rt_pp1_buf0();
            end
            else begin
                //$display(" -- pp1 buf2");
                check_rt_pp1_buf2();
            end
        end
    end

    //always @(posedge stage_done[5]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    if (stage_status[5]) begin
    //        $display("\nCheck output upper RAM of stage-5\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf2");
    //            check_rt_pp3_buf2();
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf3");
    //            check_rt_pp3_buf3();
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf4");
    //            check_rt_pp3_buf4();
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf0");
    //            check_rt_pp3_buf0();
    //        end
    //        else begin
    //            $display(" -- buf1");
    //            check_rt_pp3_buf1();
    //        end
    //    end
    //end

    always @(posedge stage_done[7]) begin
        if (stage_status[7]) begin
            $display("\nCheck timeslot %d output lower RAM of stage-7\n", ts);
            if (rt_lower_state == 0) begin
                //$display(" -- pp2 buf0");
                check_rt_pp2_buf0();
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp2 buf2");
                check_rt_pp2_buf2();
            end
            else begin
                //$display(" -- pp2 buf1");
                check_rt_pp2_buf1();
            end
        end
    end

    //always @(posedge stage_done[6]) begin//no need to initialize or check upper data for stage 4, 5, 6
    //    if (stage_status[6]) begin
    //        $display("\nCheck output upper RAM of stage-6\n");
    //        if (rt_upper_state == 0) begin
    //            $display(" -- buf1");
    //            check_rt_pp3_buf1();
    //        end
    //        else if (rt_upper_state == 1) begin
    //            $display(" -- buf2");
    //            check_rt_pp3_buf2();
    //        end
    //        else if (rt_upper_state == 2) begin
    //            $display(" -- buf3");
    //            check_rt_pp3_buf3();
    //        end
    //        else if (rt_upper_state == 3) begin
    //            $display(" -- buf4");
    //            check_rt_pp3_buf4();
    //        end
    //        else begin
    //            $display(" -- buf0");
    //            check_rt_pp3_buf0();
    //        end
    //    end
    //end

    always @(posedge stage_done[8]) begin
        if (stage_status[8]) begin
            $display("\nCheck timeslot %d output lower RAM of stage-8\n", ts);
            if (rt_lower_state == 0) begin
                //$display(" -- pp2 buf1");
                check_rt_pp2_buf1();
            end
            else if (rt_lower_state == 1) begin
                //$display(" -- pp2 buf0");
                check_rt_pp2_buf0();
            end
            else begin
                //$display(" -- pp2 buf2");
                check_rt_pp2_buf2();
            end
        end
    end

    always @(posedge stage_done[9]) begin
        if (stage_status[9] & (!is_stall) & (!is_trace)) begin
        //if (stage_status[7]) begin
            $display("\nCheck timeslot %d output lower RAM of stage-9\n", ts);
            check_reduce_buffer({test_data_dir, "stg9_out_x4.txt"});
        end
    end

    // stage 10 single stage check
    always @(posedge stage_done[10]) begin
        if (stage_status[10]) begin
            $display("\nCheck timeslot %d output of stage-10 partial test\n", ts);
            check_ddr_mem({test_data_dir, "stg10_in_x4.txt"});
        end
    end
    // stage 10 full case check
    always @(posedge interrupt) begin
        if (stage0_mode) begin
            $display("\nCheck timeslot %d output of stage-10 full test\n", ts);
            check_ddr_mem({test_data_dir, "stg10_in_x4.txt"});
        end
    end
