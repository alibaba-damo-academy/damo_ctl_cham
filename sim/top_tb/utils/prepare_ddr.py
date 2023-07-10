#!/usr/bin/python3
import os, sys, subprocess

func_name = f'ddr'
HEAD = f'\033[1m\033[92m[ {func_name:<12}]\033[0m'

def read_file(filename):
    lines = []
    with open(filename, 'r') as f:
        for line in f:
            lines.append(line.strip())
    return lines

def write_file(f, lst):
    for elt in lst:
        f.write(f'{elt}\n')

def max_timeslot(test_dir):
    with open(f'{test_dir}/info.txt') as f:
        for line in f:
            words = line.split()
            if len(words) > 0 and words[0].isnumeric():
                max_ts = int(words[0])
    return max_ts

def test_parameters(test_dir):
    with open(f'{test_dir}/info.txt') as f:
        for line in f:
            words = line.split()
            if 'level' in line:
                level = int(words[1])
            elif 'col_size' in line:
                col_size = int(words[1])
            elif 'n_split' in line:
                n_split = int(words[1])
            elif 'n_index' in line:
                n_index = int(words[1])
            elif 'mat_len' in line:
                mat_len = int(words[1])
    return (level, col_size, n_split, n_index, mat_len)

def prepare_ddr_vec(test_dir):
    to_dir = f'{test_dir}/t0000'
    print(f'{HEAD} prepare {to_dir}/ddr_in_vec.txt')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)

    with open(f'{to_dir}/ddr_in_vec.txt', 'w') as fw:
        n_rows = 0
        _, _, n_split, _, mat_len = test_parameters(test_dir)
        for ts in range(1, max_timeslot(test_dir) + 1):
            dir_name = f'{test_dir}/t{str(ts).zfill(4)}'
            for file in os.listdir(dir_name):
                if file.startswith(f'stg1_'):
                    if n_rows < n_split * 2:
                        a = read_file(f'{dir_name}/stg1_a_in_x3.txt')
                        b = read_file(f'{dir_name}/stg1_b_in_x3.txt')
                        write_file(fw, a + b)
                    n_rows += 2
                    break
        assert(n_rows == n_split * 2 + mat_len)

# DDR for partial test
def prepare_ddr_partial(from_dir, to_dir):
    print(f'{HEAD} prepare {to_dir}/ddr_in_partial.txt')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)

    with open(f'{to_dir}/ddr_in_partial.txt', 'w') as fw:
        assert(os.path.isfile(f'{from_dir}/stg1_a_in_x3.txt'))
        assert(os.path.isfile(f'{from_dir}/stg1_b_in_x3.txt'))
        a = read_file(f'{from_dir}/stg1_a_in_x3.txt')
        b = read_file(f'{from_dir}/stg1_b_in_x3.txt')
        write_file(fw, a + b)

def prepare_ddr_mat(test_dir):
    to_dir = f'{test_dir}/t0000'
    print(f'{HEAD} prepare {to_dir}/ddr_in_mat.txt')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)

    with open(f'{to_dir}/ddr_in_mat.txt', 'w') as fw:
        n_rows = 0
        _, _, n_split, _, mat_len = test_parameters(test_dir)
        for ts in range(1, max_timeslot(test_dir) + 1):
            dir_name = f'{test_dir}/t{str(ts).zfill(4)}'
            for file in os.listdir(dir_name):
                if file.startswith(f'stg1_'):
                    if n_rows >= n_split * 2:
                        a = read_file(f'{dir_name}/stg1_a_in_x3.txt')
                        b = read_file(f'{dir_name}/stg1_b_in_x3.txt')
                        write_file(fw, a + b)
                    n_rows += 2
                    break
        assert(n_rows == n_split * 2 + mat_len)

def prepare_ddr_ksk(from_dir, to_dir):
    print(f'{HEAD} prepare {to_dir}/ddr_in_ksk.txt')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)

    with open(f'{to_dir}/ddr_in_ksk.txt', 'w') as fw:
        for i in range(12):
            a = read_file(f'{from_dir}/k{i+1}.txt')
            write_file(fw, a)

if __name__ == '__main__':
    assert(len(sys.argv) in [1, 2])
    if len(sys.argv) == 2:
        test_name = sys.argv[1]
        assert(test_name.startswith(f'test_'))
    else:
        test_name = 'test_row'

    # partial test
    if 'stg' in test_name or 'row' in test_name:
        test_dir = '../../../tv/basic'
        prepare_ddr_partial(test_dir, test_dir)
        prepare_ddr_ksk(f'{test_dir}/ksk', test_dir)
    # full test
    elif 'full' in test_name:
        test_dir = '../../../tv/' + test_name.split('_')[2]
        prepare_ddr_vec(test_dir)
        prepare_ddr_mat(test_dir)
        prepare_ddr_ksk(f'{test_dir}/ksk', f'{test_dir}/t0000')
    else:
        print(f'Error: Invalid test name {test_name}!')
        
    print()
