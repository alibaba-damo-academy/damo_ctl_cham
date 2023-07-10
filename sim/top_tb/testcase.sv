if(testname == "test_stg_0_0") // single stage, stage 0 ksk uram init test
begin
    stage0_mode = 0;
    config_kernel_init();
    wait_some_cycles();
    single_test(0);
end
else if(testname == "test_stg_0_1") // single stage, stage 0 preprocess init test
begin
    stage0_mode = 1;
    config_kernel_run();
    wait_some_cycles();
    single_test(0);
end
else if(testname =="test_stg_1") // single stage, stage 1 (DP-1 NTT) test
begin
    single_test(1);
end
else if(testname =="test_stg_2") // single stage, stage 2 (DP-1 MUL+ADD) test
begin
    single_test(2);
end
else if(testname =="test_stg_3") // single stage, stage 3 (Preprocess INTT) test
begin
    single_test(3);
end
else if(testname =="test_stg_4") // single stage, stage 4 (Preprocess RS*+VPU4) test
begin
    read_index({test_data_dir, "stg4_coeff_index.txt"});
    single_test(4);
end
else if(testname =="test_stg_5") // single stage, stage 5 (MonoX) test
begin
    read_level({test_data_dir, "stg5_level.txt"});
    single_test(5);
end
else if(testname =="test_stg_6") // single stage, stage 6 (NTT) test
begin
    single_test(6);
end
else if(testname =="test_stg_7") // single stage, stage 7 (MulAcc) test
begin
    read_level({test_data_dir, "stg7_level.txt"});
    single_test(7);
end
else if(testname =="test_stg_8") // single stage, stage 8 (INTT) test
begin
    single_test(8);
end
else if(testname =="test_stg_9") // single stage, stage 9 (RS+AddX) test
begin
    single_test(9);
end
else if(testname =="test_stg_10") // single stage, stage 10 (AXI Write) test
begin
    config_kernel_run();
    wait_some_cycles();
    single_test(10);
end
else if(testname =="test_row") // test all stages in a row
begin
    basic_test();
end
else if(testname =={"test_full_", test_size, "_no_uram"}) // full case test
begin
    full_test_no_uram();
end
else if(testname =={"test_full_", test_size}) // full case test
begin
    full_test();
end
else 
begin
    $display("ERROR! Test {%0s} does not exist!\n", testname);
    $finish;
end
