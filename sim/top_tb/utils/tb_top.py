#!/usr/bin/python3

import sys, subprocess

func_name = f'tb_top'
HEAD = f'\033[1m\033[92m[ {func_name:<12}]\033[0m'

def configure_tb_top(tb_file, config_file):
    with open(config_file) as f:
        for line in f:
            words = line.split()
            if 'level' in line:
                level = int(words[1])
                print(f'{HEAD} configure LEVEL = {level}')
            elif 'col_size' in line:
                col_size = int(words[1])
                print(f'{HEAD} configure COL_SIZE = {col_size}')
            elif 'n_split' in line:
                n_split = int(words[1])
                print(f'{HEAD} configure N_SPLIT = {n_split}')
            elif 'n_index' in line:
                n_index = int(words[1])
                print(f'{HEAD} configure N_INDEX = {n_index}')
            elif 'mat_len' in line:
                mat_len = int(words[1])
                print(f'{HEAD} configure MAT_LEN = {mat_len}')
    print()

    with open(tb_file, 'r') as f:
        lines = []
        for line in f:
            if f'parameter LEVEL =' in line:
                lines.append(f'    parameter LEVEL = {level};\n')
            elif f'parameter COL_SIZE =' in line:
                lines.append(f'    parameter COL_SIZE = {col_size};\n')
            elif f'parameter N_SPLIT =' in line:
                lines.append(f'    parameter N_SPLIT = {n_split};\n')
            elif f'parameter N_INDEX =' in line:
                lines.append(f'    parameter N_INDEX = {n_index};\n')
            elif f'parameter MAT_LEN =' in line:
                lines.append(f'    parameter MAT_LEN = {mat_len};\n')
            else:
                lines.append(line)

    with open(tb_file, 'w') as f:
        for line in lines:
            f.write(line)

def configure_test_dir(tb_file, test_name):
    print(f'{HEAD} configure test_dir as {test_name}')
    with open(tb_file, 'r') as f:
        lines = []
        for line in f:
            if f'assign test_size     =' in line:
                lines.append(f'        assign test_size     = \"{test_name}\";\n')
            else:
                lines.append(line)

    with open(tb_file, 'w') as f:
        for line in lines:
            f.write(line)


if __name__ == '__main__':
    assert(len(sys.argv) in [1, 2])
    if len(sys.argv) == 2:
        test_name = sys.argv[1]
        assert(test_name.startswith(f'test_'))
    else:
        test_name = 'test_row'

    # duplicate current_tb_top.sv from tb_top.sv
    print(f'{HEAD} create ../current_tb_top.sv as copy of ../tb_top.sv')
    subprocess.run([f'cp', f'../tb_top.sv', f'../current_tb_top.sv'])

    # partial test
    if 'stg' in test_name or 'row' in test_name:
        test_dir = '../../../tv/basic'
        configure_tb_top(f'../current_tb_top.sv', f'{test_dir}/info.txt')
    # full test
    elif 'full' in test_name:
        test_dir = '../../../tv/' + test_name.split('_')[2]
        configure_tb_top(f'../current_tb_top.sv', f'{test_dir}/info.txt')
        configure_test_dir(f'../current_tb_top.sv', test_name.split('_')[2])
    else:
        print(f'Error: Invalid test name {test_name}!')
