#!/usr/bin/python3
import os, sys, subprocess

func_name = f'axi_stg_dat'
HEAD = f'\033[1m\033[92m[ {func_name:<12}]\033[0m'

def max_timeslot(test_dir):
    with open(f'{test_dir}/info.txt') as f:
        for line in f:
            words = line.split()
            if len(words) > 0 and words[0].isnumeric():
                max_ts = int(words[0])
    return max_ts

def prepare_t0_output(from_dir, to_dir):
    print(f'{HEAD} prepare stg0 at t0')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)
    if(os.path.exists(f'{from_dir}/stg1_a_in_x3.txt')):
        subprocess.run([f'cp', f'{from_dir}/stg1_a_in_x3.txt', f'{to_dir}/stg0_a_out_x3.txt'])
    if(os.path.exists(f'{from_dir}/stg1_b_in_x3.txt')):
        subprocess.run([f'cp', f'{from_dir}/stg1_b_in_x3.txt', f'{to_dir}/stg0_b_out_x3.txt'])

def prepare_tN_input(from_dir, to_dir):
    print(f'{HEAD} prepare stg10 at t{{N+1}}')
    if not os.path.isdir(to_dir):
        os.mkdir(to_dir)
    if(os.path.exists(f'{from_dir}/stg9_out_x4.txt')):
        subprocess.run([f'cp', f'{from_dir}/stg9_out_x4.txt', f'{to_dir}/stg10_in_x4.txt'])

def prepare_t0_to_tN(test_dir, max_ts):
    # t0
    prepare_t0_output(f'{test_dir}/t0001', f'{test_dir}/t0000')
    # t1 ~ tN
    print(f'{HEAD} prepare t0001/ to t{str(max_ts).zfill(4)}')
    for to_ts in range(1, max_ts):
        to_dir = f'{test_dir}/t{str(to_ts).zfill(4)}'
        if not os.path.exists(f'{to_dir}/stg1_a_in_x3.txt'):
            continue
        for from_ts in range(to_ts + 1, max_ts + 1):
            from_dir = f'{test_dir}/t{str(from_ts).zfill(4)}'
            if(os.path.exists(f'{from_dir}/stg1_a_in_x3.txt')):
                subprocess.run([f'cp', f'{from_dir}/stg1_a_in_x3.txt', f'{to_dir}/stg0_a_out_x3.txt'])
                subprocess.run([f'cp', f'{from_dir}/stg1_b_in_x3.txt', f'{to_dir}/stg0_b_out_x3.txt'])
                break
    # t{N+1}
    prepare_tN_input(f'{test_dir}/t{str(max_ts).zfill(4)}', f'{test_dir}/t{str(max_ts + 1).zfill(4)}')

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
        prepare_t0_output(test_dir, test_dir)
        prepare_tN_input(test_dir, test_dir)
    # full test
    elif 'full' in test_name:
        test_dir = '../../../tv/' + test_name.split('_')[2]
        max_ts = max_timeslot(test_dir)
        prepare_t0_to_tN(test_dir, max_ts)
    else:
        print(f'Error: Invalid test name {test_name}!')

    print()
