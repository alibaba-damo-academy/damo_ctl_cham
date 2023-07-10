<h1 align="center">CHAM</h1>
<h4 align="center">A Customized Homomorphic Encryption Accelerator for Fast Matrix-Vector Product</h4>

The __CHAM__ project is initiated by Alibaba DAMO Academy CTL and Ant Group's AntChain.

___CHAM___ is a customized homomorphic encryption accelerator for fast matrix-vector product. Homomorphic encryption (HE), enabling computation on encrypted data, suffers from poor performance due to enlarged data size and exploded amount of computation. Existing HE accelerators either target small HE operations or fail to support fast-evolving HE algorithms. To better support various privacy-preserving applications (e.g., logistic regression and neural-network inference), we propose CHAM for high-performance matrix-vector product, which can be easily extended to 2D/3D convolutions. 

The code in this repository is released by Alibaba DAMO Academy CTL and Ant Group's AntChain under MIT License.

The distribution is developed as part of our DAC2023 paper called *"CHAM: A Customized Homomorphic Encryption Accelerator for Fast Matrix-Vector Product"*. This distribution is an open-source version of our commercial accelerator and not ready for production use.


## Table of contents

- [Directory structure](#directory-structure)
- [Build guide](#build-guide)
- [License](#license)

## Directory structure

The directory structure is as follows:

* [__src__](src): RTL source files
* [__include__](include): include files
* [__sim__](sim): simulation environment
* [__tv__](tv): test vectors
* [__xilinx_vcs_lib__](xilinx_vcs_lib): xilinx vcs simulation library


## Build guide

1. Generate xilinx vcs lib in ./xilinx_vcs_lib
2. Modify sim/vcs/tb_top.sh line 48 to your vcs path
3. cd sim
4. make clean //remove the previous run_dir
5. ./run_case <test name>//test name is showing below in Test cases
    test_stg_0_0                test single stage at stage 0, and test only ksk ram init path
    test_stg_0_1                test single stage at stage 0, and test only preprocess init path
    test_stg_1                  test single stage at stage 1
    test_stg_2                  test single stage at stage 2
    test_stg_3                  test single stage at stage 3
    test_stg_4                  test single stage at stage 4
    test_stg_5                  test single stage at stage 5
    test_stg_6                  test single stage at stage 6
    test_stg_7                  test single stage at stage 7
    test_stg_8                  test single stage at stage 8
    test_stg_9                  test single stage at stage 9
    test_stg_10                 test single stage at stage 10
    test_row                    test all stages in a row
    test_full_no_uram_4x4096    test full case, the test vector is 4x4096. we use testbench to init ksk ram instead of designtest_full_4x4096            test full case, the test vector is 4x4096.
    test_full_4x4096            test full case, the test vector is 4x4096.

## License

[MIT License](LICENSE)

This product contains several third-party components under other open source licenses.

    src/axi/axi_read_master.sv          BSD-2-Clause        Vitis-Tutorials
    src/axi/axi_write_master.sv         BSD-2-Clause        Vitis-Tutorials
    src/axi/counter.sv                  BSD-2-Clause        Vitis-Tutorials
