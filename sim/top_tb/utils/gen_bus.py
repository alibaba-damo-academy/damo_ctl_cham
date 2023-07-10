#!/usr/bin/python3

import sys

def GenBuf():
    gen = []
    tab = f'    '

    gen.append(f'parameter DP_PP_COE_WIDTH = 39;')
    gen.append(f'parameter PP_PP_COE_WIDTH = 39;')
    gen.append(f'parameter RB_PP_COE_WIDTH = 35;')

    gen.append(f'int fp_r0;')
    gen.append(f'int fp_r1;')
    gen.append(f'int flag; // $fscanf')

    ##########################################
    ######dotproduct init and check###########
    ##########################################
    gen.append(f'// -------------------------------------')
    gen.append(f'// dotproduct Ping-pong buffer init')
    gen.append(f'// -------------------------------------')
    gen.append(f'int _dp_idx;')
    gen.append(f'logic [DP_PP_COE_WIDTH-1:0] _dp_temp0 [0:3*4096-1];')
    gen.append(f'logic [DP_PP_COE_WIDTH-1:0] _dp_temp1 [0:3*4096-1];')

    mem = 'tri_pp'
    gen.append(f'{tab*1}// --------------------------------------------')
    gen.append(f'{tab*1}// init dotprodct Ping-pong buffer {mem}')
    gen.append(f'{tab*1}// --------------------------------------------')
    gen.append(f'')

    for n_mem in range(2):
        for n_buf in range(3):
            gen.append(f'{tab*1}task initialize_dp_{mem}{n_mem}_buf{n_buf}_as_input(string filename);')
            gen.append(f'{tab*2}fp_r{n_mem} = $fopen(filename, "r");')
            gen.append(f'{tab*2}if (fp_r{n_mem} == 0) begin')
            gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
            gen.append(f'{tab*3}$finish;')
            gen.append(f'{tab*2}end')
            gen.append(f'{tab*2}for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin')
            gen.append(f'{tab*3}flag = $fscanf(fp_r{n_mem}, "%h", _dp_temp{n_mem}[_dp_idx]);')
            gen.append(f'{tab*2}end')
            gen.append(f'')
            for n_poly in range(3):
                for n_bank in range(8):
                    gen.append(f'{tab*2}`DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank = _dp_temp{n_mem}[{n_bank}*512+{n_poly}*4096 +: 512];')
            gen.append(f'{tab*1}endtask')
            gen.append(f'')

    gen.append(f'// -------------------------------------')
    gen.append(f'// dotproduct Ping-pong buffer check')
    gen.append(f'// -------------------------------------')
    gen.append(f'logic [DP_PP_COE_WIDTH-1:0] _dp_model_data [0:16383];')
    gen.append(f'')

    mem = 'tri_pp'
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}// check dotproduct Ping-pong buffer {mem}')
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'')

    for n_mem in range(2):
        for n_buf in range(3):
            gen.append(f'{tab*1}task check_dp_{mem}{n_mem}_buf{n_buf}_as_output(string filename);')
            gen.append(f'{tab*2}fp_r{n_mem} = $fopen(filename, "r");')
            gen.append(f'{tab*2}if (fp_r{n_mem} == 0) begin')
            gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
            gen.append(f'{tab*3}$finish;')
            gen.append(f'{tab*2}end')
            gen.append(f'{tab*2}for (_dp_idx = 0; _dp_idx < 16384; _dp_idx = _dp_idx + 1) begin')
            gen.append(f'{tab*3}flag = $fscanf(fp_r{n_mem}, "%h", _dp_model_data[_dp_idx]);')
            gen.append(f'{tab*2}end')
            gen.append(f'')
            for n_poly in range(3):
                for n_bank in range(8):
                    gen.append(f'{tab*2}for (_dp_idx = 0; _dp_idx < 512; _dp_idx = _dp_idx + 1) begin')
                    gen.append(f'{tab*3}if (`DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank[_dp_idx] === _dp_model_data[{n_poly}*4096+{n_bank}*512+_dp_idx])')
                    gen.append(f'{tab*3}begin')
                    gen.append(f'{tab*3}end')
                    gen.append(f'{tab*3}else begin')
                    gen.append(f'{tab*4}$display("`DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\\n",')
                    gen.append(f'{tab*4}         _dp_idx,')
                    gen.append(f'{tab*4}         `DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank[_dp_idx],')
                    gen.append(f'{tab*4}         _dp_model_data[{n_poly}*4096+{n_bank}*512+_dp_idx]')
                    gen.append(f'{tab*4});')
                    gen.append(f'{tab*4}$display("`DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\\n",')
                    gen.append(f'{tab*4}         _dp_idx,')
                    gen.append(f'{tab*4}         `DP.{mem}{n_mem}.polyvec_{n_buf}.genblk1[{n_poly}].polynomial.genblk1[{n_bank}].base_bank.mem_bank[_dp_idx],')
                    gen.append(f'{tab*4}         _dp_model_data[{n_poly}*4096+{n_bank}*512+_dp_idx]')
                    gen.append(f'{tab*4});')
                    gen.append(f'{tab*4}$finish;')
                    gen.append(f'{tab*3}end')
                    gen.append(f'{tab*2}end')
            gen.append(f'{tab*1}endtask')
            gen.append(f'')

    ##########################################
    ######dotproduct ciphertext uram init#####
    ##########################################
    gen.append(f'// -------------------------------------')
    gen.append(f'// dotproduct ciphertext uram init')
    gen.append(f'// -------------------------------------')
    gen.append(f'int _ct_idx;')
    gen.append(f'int _ct_split_idx;')
    gen.append(f'')
    gen.append(f'logic [DP_PP_COE_WIDTH-1:0] _ct_temp [6*4096-1:0];')
    gen.append(f'')
    gen.append(f'{tab*1}task initialize_dp_ctxt_uram(string filename, int n_split);')
    gen.append(f'{tab*2}fp_r0 = $fopen(filename, "r");')
    gen.append(f'{tab*2}if (fp_r0 == 0) begin')
    gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
    gen.append(f'{tab*3}$finish;')
    gen.append(f'{tab*2}end')
    gen.append(f'')
    gen.append(f'{tab*2}for (_ct_split_idx = 0; _ct_split_idx < n_split; _ct_split_idx = _ct_split_idx + 1) begin')
    gen.append(f'{tab*3}for (_ct_idx = 0; _ct_idx < 6*4096; _ct_idx = _ct_idx + 1) begin')
    gen.append(f'{tab*4}flag = $fscanf(fp_r0, "%h", _ct_temp[_ct_idx]);')
    gen.append(f'{tab*3}end')
    gen.append(f'{tab*3}case (_ct_split_idx)')
    for n in range(4):
        gen.append(f'{tab*4}{n}: begin')
        for n_poly in range(6):
            gen.append(f'{tab*5}`DP.ctxt_polyvec.genblk2[{n}].polyvec_ntt_ctxt{n_poly%2}.genblk1[{n_poly//2}].uram_inst.mem = _ct_temp[({n_poly}+1)*4096-1 -: 4096];')
        gen.append(f'{tab*4}end')
    gen.append(f'{tab*3}endcase')
    gen.append(f'{tab*2}end')
    gen.append(f'{tab*1}endtask')
    gen.append(f'')

    ##########################################
    ######preprocess init and check###########
    ##########################################
    gen.append(f'// -------------------------------------')
    gen.append(f'// preprocess Ping-pong buffer init')
    gen.append(f'// -------------------------------------')
    gen.append(f'int _pp_idx;')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_temp0 [0:6*4096-1];')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_temp1 [0:6*4096-1];')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_temp0 [0:4*4096-1];')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_temp1 [0:4*4096-1];')
    gen.append(f'')

    for ppi in range(2):
        mem = f'tpp' if ppi == 0 else f'dpp'
        gen.append(f'{tab*1}// --------------------------------------------')
        gen.append(f'{tab*1}// init preprocess Ping-pong buffer {mem}')
        gen.append(f'{tab*1}// --------------------------------------------')
        gen.append(f'')

        buf_num = 3 if ppi == 0 else 2
        poly_num = 6 if ppi == 0 else 4
        for n_pp in range(2):
            for n_buf in range(buf_num):
                gen.append(f'{tab*1}task initialize_pp{n_pp}_{mem}_buf{n_buf}_as_input(string filename);')
                gen.append(f'{tab*2}fp_r{n_pp} = $fopen(filename, "r");')
                gen.append(f'{tab*2}if (fp_r{n_pp} == 0) begin')
                gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
                gen.append(f'{tab*3}$finish;')
                gen.append(f'{tab*2}end')
                gen.append(f'{tab*2}for (_pp_idx = 0; _pp_idx < {poly_num*4096}; _pp_idx = _pp_idx + 1) begin')
                gen.append(f'{tab*3}flag = $fscanf(fp_r{n_pp}, "%h", _pp_{mem}_temp{n_pp}[_pp_idx]);')
                gen.append(f'{tab*2}end')
                gen.append(f'')
                for n_poly in range(poly_num):
                    for n_bank in range(8):
                        gen.append(f'{tab*2}for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin')
                        gen.append(f'{tab*2}`PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[_pp_idx]')
                        gen.append(f'{tab*2}    = _pp_{mem}_temp{n_pp}[{n_poly}*4096 + {n_bank}*512 + _pp_idx];')
                        gen.append(f'{tab*2}end')
                gen.append(f'{tab*1}endtask')
                gen.append(f'')

    gen.append(f'// -------------------------------------')
    gen.append(f'// preprocess Ping-pong buffer check')
    gen.append(f'// -------------------------------------')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_tpp_model_data [0:6*4096-1];')
    gen.append(f'logic [PP_PP_COE_WIDTH-1:0] _pp_dpp_model_data [0:4*4096-1];')
    gen.append(f'')

    for ppi in range(2):
        mem = f'tpp' if ppi == 0 else f'dpp'
        gen.append(f'{tab*1}// -------------------------------------')
        gen.append(f'{tab*1}// check preprocess Ping-pong buffer {mem}')
        gen.append(f'{tab*1}// -------------------------------------')

        buf_num = 3 if ppi == 0 else 2
        poly_num = 6 if ppi == 0 else 4
        for n_pp in range(2):
            for n_buf in range(buf_num):
                gen.append(f'{tab*1}task check_pp{n_pp}_{mem}_buf{n_buf}_as_output(string filename);')
                gen.append(f'{tab*2}fp_r{n_pp} = $fopen(filename, "r");')
                gen.append(f'{tab*2}if (fp_r{n_pp} == 0) begin')
                gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
                gen.append(f'{tab*3}$finish;')
                gen.append(f'{tab*2}end')
                gen.append(f'{tab*2}for (_pp_idx = 0; _pp_idx < {poly_num*4096}; _pp_idx = _pp_idx + 1) begin')
                gen.append(f'{tab*3}flag = $fscanf(fp_r{n_pp}, "%h", _pp_{mem}_model_data[_pp_idx]);')
                gen.append(f'{tab*2}end')
                gen.append(f'')
                for n_poly in range(poly_num):
                    for n_bank in range(8):
                        gen.append(f'{tab*2}for (_pp_idx = 0; _pp_idx < 512; _pp_idx = _pp_idx + 1) begin')
                        gen.append(f'{tab*3}if (`PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[_pp_idx] ===')
                        gen.append(f'{tab*3}    _pp_{mem}_model_data[{n_poly}*4096 + {n_bank}*512 + _pp_idx]) begin')
                        gen.append(f'{tab*3}end')
                        gen.append(f'{tab*3}else begin')
                        gen.append(f'{tab*4}$display("`PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[%d] out value %d wrong! Correct value should be %d !\\n",')
                        gen.append(f'{tab*4}         _pp_idx,')
                        gen.append(f'{tab*4}         `PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[_pp_idx],')
                        gen.append(f'{tab*4}         _pp_{mem}_model_data[{n_poly}*4096 + {n_bank}*512 + _pp_idx]')
                        gen.append(f'{tab*4});')
                        gen.append(f'{tab*4}$display("`PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[%d] out value %h wrong! Correct value should be %h !\\n",')
                        gen.append(f'{tab*4}         _pp_idx,')
                        gen.append(f'{tab*4}         `PP{n_pp}.u_{mem}_{n_poly}.u_ram_{n_buf}.u_ram.genblk1[{n_bank}].base_bank.mem_bank[_pp_idx],')
                        gen.append(f'{tab*4}         _pp_{mem}_model_data[{n_poly}*4096 + {n_bank}*512 + _pp_idx]')
                        gen.append(f'{tab*4});')
                        gen.append(f'{tab*4}$finish;')
                        gen.append(f'{tab*3}end')
                        gen.append(f'{tab*2}end')
                gen.append(f'{tab*1}endtask')
                gen.append(f'')


    n_poly = 6
    poly_size_rb = 12
    modulus = [f'Q0', f'Q1', f'P']

    ##########################################
    ######reduce_trace init and check#########
    ##########################################
    gen.append(f'// ----------------------------------------')
    gen.append(f'// reduce_trace buffer initialize and check')
    gen.append(f'// ----------------------------------------')
    gen.append(f'logic [COE_WIDTH-1:0] temp2;')
    gen.append(f'')
    for pp_i in range(1, 4):
        gen.append(f'{tab*1}// -------------------------------------')
        gen.append(f'{tab*1}// reduce_trace Ping-pong buffer {pp_i}')
        gen.append(f'{tab*1}// -------------------------------------')
        n_buf = 5 if pp_i == 3 else 3
        for buf_i in range(n_buf):
            for io in [f'input', f'output']:
                mem = f'temp_mem' if io == f'input' else f'gold_mem'
                gen.append(f'{tab*1}task initialize_rt_pp{pp_i}_buf{buf_i}_as_{io}(string filename);')
                gen.append(f'{tab*2}fd = $fopen(filename, "r");')
                gen.append(f'{tab*2}if(fd == 0) begin')
                gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
                gen.append(f'{tab*3}$finish;')
                gen.append(f'{tab*2}end')
                for k in range(n_poly):
                    gen.append(f'{tab*2}for (i = 0; i < POLY_SIZE; i++) begin')
                    gen.append(f'{tab*3}rt = $fscanf(fd, "%h", temp2);')
                    crt_modulus = modulus[k%2] if pp_i == 3 else modulus[k//2]
                    gen.append(f'{tab*3}assert(temp2 < {crt_modulus}) else $display("Assert Error: pp{pp_i}_buf{buf_i}_as_{io}[{k}], addr = %d, data = %h\\n", i, temp2);')
                    gen.append(f'{tab*3}`RT.g{pp_i}[{k}].pp.buf{buf_i}.{mem}[i] = temp2;')
                    gen.append(f'{tab*2}end')
                gen.append(f'{tab*2}$fclose(fd);')
                gen.append(f'{tab*2}wait_quarter_cycle();')
                if io == f'input':
                    for k in range(n_poly):
                        gen.append(f'{tab*2}`RT.g{pp_i}[{k}].pp.buf{buf_i}.init = 1;')
                    gen.append(f'{tab*2}wait_quarter_cycle();')
                    for k in range(n_poly):
                        gen.append(f'{tab*2}`RT.g{pp_i}[{k}].pp.buf{buf_i}.init = 0;')
                    # gen.append(f'{tab*2}wait_one_cycle();')
                gen.append(f'{tab*1}endtask')
                gen.append(f'')

            gen.append(f'{tab*1}task check_rt_pp{pp_i}_buf{buf_i}();')
            # gen.append(f'{tab*2}wait_one_cycle();')
            for k in range(n_poly):
                gen.append(f'{tab*2}`RT.g{pp_i}[{k}].pp.buf{buf_i}.check = 1;')
            gen.append(f'{tab*2}wait_one_cycle();')
            for k in range(n_poly):
                gen.append(f'{tab*2}`RT.g{pp_i}[{k}].pp.buf{buf_i}.check = 0;')
            gen.append(f'{tab*2}wait_one_cycle();')
            gen.append(f'{tab*1}endtask')
            gen.append(f'\n')

    ##########################################
    #######reducebuffer init and check#########
    ##########################################
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}// Reduce buffer init for stage 8 test')
    gen.append(f'{tab*1}// -------------------------------------')

    gen.append(f'{tab*1}logic [RB_PP_COE_WIDTH-1:0] _rb_temp;')

    gen.append(f'{tab*1}task initialize_reduce_buffer(string filename);')
    gen.append(f'{tab*2}fp_r0 = $fopen(filename, "r");')
    gen.append(f'{tab*2}if(fp_r0 == 0) begin')
    gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
    gen.append(f'{tab*3}$finish;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')
    gen.append(f'{tab*2}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
    gen.append(f'{tab*3}flag = $fscanf(fp_r0, "%h", _rb_temp);')
    gen.append(f'{tab*3}`RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] = _rb_temp;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')
    gen.append(f'{tab*2}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
    gen.append(f'{tab*3}flag = $fscanf(fp_r0, "%h", _rb_temp);')
    gen.append(f'{tab*3}`RB.genblk1[0].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] = _rb_temp;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')
    gen.append(f'{tab*2}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
    gen.append(f'{tab*3}flag = $fscanf(fp_r0, "%h", _rb_temp);')
    gen.append(f'{tab*3}`RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] = _rb_temp;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')
    gen.append(f'{tab*2}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
    gen.append(f'{tab*3}flag = $fscanf(fp_r0, "%h", _rb_temp);')
    gen.append(f'{tab*3}`RB.genblk1[0].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] = _rb_temp;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')
    gen.append(f'{tab*1}endtask')

    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}// Reduce buffer check')
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}task check_reduce_buffer(string filename);')
    gen.append(f'{tab*2}fp_r0 = $fopen(filename, "r");')
    gen.append(f'{tab*2}if(fp_r0 == 0) begin')
    gen.append(f'{tab*3}$display("ERROR!!! Cannot find file %s \\n", filename);')
    gen.append(f'{tab*3}$finish;')
    gen.append(f'{tab*2}end')
    gen.append(f'\n')

    for rb_buffer_index in range(poly_size_rb):
        gen.append(f'{tab*2}if(rt_buffer_wr_index === {rb_buffer_index}) begin')

        gen.append(f'{tab*3}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
        gen.append(f'{tab*4}flag = $fscanf(fp_r0, "%h", _rb_temp);')
        gen.append(f'{tab*4}if(`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)')
        gen.append(f'{tab*4}begin')
        gen.append(f'{tab*4}end')
        #gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value correct!\\n", i);')
        gen.append(f'{tab*4}else begin')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);')
        gen.append(f'{tab*5}$finish;')
        gen.append(f'{tab*4}end')
        gen.append(f'{tab*3}end')

        gen.append(f'{tab*3}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
        gen.append(f'{tab*4}flag = $fscanf(fp_r0, "%h", _rb_temp);')
        gen.append(f'{tab*4}if(`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)')
        gen.append(f'{tab*4}begin')
        gen.append(f'{tab*4}end')
        #gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value correct!\\n", i);')
        gen.append(f'{tab*4}else begin')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst0.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);')
        gen.append(f'{tab*5}$finish;')
        gen.append(f'{tab*4}end')
        gen.append(f'{tab*3}end')

        gen.append(f'{tab*3}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
        gen.append(f'{tab*4}flag = $fscanf(fp_r0, "%h", _rb_temp);')
        gen.append(f'{tab*4}if(`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0] === _rb_temp)')
        gen.append(f'{tab*4}begin')
        gen.append(f'{tab*4}end')
        #gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value correct!\\n", i);')
        gen.append(f'{tab*4}else begin')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %h wrong!!! Correct value should be %h !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH-1:0] out value %d wrong!!! Correct value should be %d !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH-1:0], _rb_temp);')
        gen.append(f'{tab*5}$finish;')
        gen.append(f'{tab*4}end')
        gen.append(f'{tab*3}end')

        gen.append(f'{tab*3}for(i = 0; i < POLY_SIZE; i = i + 1) begin')
        gen.append(f'{tab*4}flag = $fscanf(fp_r0, "%h", _rb_temp);')
        gen.append(f'{tab*4}if(`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] === _rb_temp)')
        #gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value correct!\\n", i);')
        gen.append(f'{tab*4}begin')
        gen.append(f'{tab*4}end')
        gen.append(f'{tab*4}else begin')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %h wrong!!! Correct value should be %h !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);')
        gen.append(f'{tab*5}$display("`RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[%d][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH] out value %d wrong!!! Correct value should be %d !!!\\n", i, `RB.genblk1[{rb_buffer_index}].upv_inst.uram_inst1.mem[i][RB_PP_COE_WIDTH*2-1:RB_PP_COE_WIDTH], _rb_temp);')
        gen.append(f'{tab*5}$finish;')
        gen.append(f'{tab*4}end')
        gen.append(f'{tab*3}end')

        gen.append(f'{tab*2}end')
        gen.append(f'\n')

    gen.append(f'{tab*1}endtask')

    ##########################################
    ##########ksk uram check##################
    ##########################################
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}// KSK URAM check')
    gen.append(f'{tab*1}// -------------------------------------')
    gen.append(f'{tab*1}task check_ksk_uram;')
    for ksk_uram_index in range(12):
        gen.append(f'{tab*2}fd = $fopen({{RUN_DIR, "vcs/", "uram_k{ksk_uram_index}.mem"}}, "r");')
        gen.append(f'{tab*2}if(fd == 0) begin')
        gen.append(f'{tab*3}$display("ERROR!!! Cannot find file uram_k{ksk_uram_index}.mem ! \\n");')
        gen.append(f'{tab*3}$finish;')
        gen.append(f'{tab*2}end')
        gen.append(f'{tab*2}for(i = 0; i < 6144; i = i + 1) begin')
        gen.append(f'{tab*3}rt = $fscanf(fd, "%h", ksk_mem);')
        gen.append(f'{tab*3}if(gen_ksk_model[{ksk_uram_index}].i_ksk_uram_model.base_bank.mem_bank[i] === ksk_mem)')
        gen.append(f'{tab*3}begin')
        gen.append(f'{tab*3}end')
        gen.append(f'{tab*3}else begin')
        gen.append(f'{tab*4}$display("gen_ksk_model[{ksk_uram_index}].i_ksk_uram_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\\n", i,gen_ksk_model[{ksk_uram_index}].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);')
        gen.append(f'{tab*4}$display("gen_ksk_model[{ksk_uram_index}].i_ksk_uram_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\\n", i,gen_ksk_model[{ksk_uram_index}].i_ksk_uram_model.base_bank.mem_bank[i] , ksk_mem);')
        gen.append(f'{tab*4}$finish;')
        gen.append(f'{tab*3}end')
        gen.append(f'{tab*2}end')
        gen.append(f'\n')
    gen.append(f'{tab*1}endtask')

    return gen

if __name__ == '__main__':
    assert len(sys.argv) == 1

    fo = open('../task.sv', 'w')
    gen = GenBuf()
    for line in gen:
        fo.write(line + '\n')
    fo.write('\n\n\n')

