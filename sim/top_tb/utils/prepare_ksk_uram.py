#!/usr/bin/python3
import os, sys, subprocess

func_name = f'ksk_uram'
HEAD = f'\033[1m\033[92m[ {func_name:<12}]\033[0m'

def pack_every_delta(lst, delta):
    i = 0
    data_width = 39
    new_lst = []
    while(i < len(lst)):
        temp = 0
        for k in reversed(range(delta)):
            temp <<= data_width
            elt = int(lst[i + k].strip(), 16)
            assert((elt >> data_width) == 0)
            temp += elt
        new_lst.append('%x' % temp)
        i += delta
    return new_lst

def write_file(f, lst):
    for elt in lst:
        f.write(f'{elt}\n')

def read_files(dir_name, index):
    lines = []
    start_line = index * 4096
    end_line = (index + 1) * 4096
    for i in range(12):
        count = 0
        with open(f'{dir_name}/k{i+1}.txt', 'r') as f:
            for line in f:
                if count >= start_line and count < end_line:
                    lines.append(line.strip())
                count += 1
    return lines

def copy_and_reorder_ksk(from_dir, to_dir):
    print(f'{HEAD} copy and reorder ksk ({from_dir}/ksk/)')
    dir_name = f'{from_dir}/ksk'

    if not os.path.isdir(f'{to_dir}/ksk/'):
        os.mkdir(f'{to_dir}/ksk/')

    new_order = [0, 3, 6, 9, 1, 4, 7, 10, 2, 5, 8, 11]
    for file in os.listdir(dir_name):
        subprocess.run([f'cp', f'{from_dir}/ksk/{file}', f'{to_dir}/ksk/temp.txt'])
        with open(f'{to_dir}/ksk/temp.txt', 'r') as f:
            ksk = []
            i = 0
            x = []
            for line in f:
                x.append(int(line.strip(), 16))
                i += 1
                if i == 4096:
                    ksk.append(x)
                    x = []
                    i = 0
            ksk = [ksk[i] for i in new_order]
            fw = open(f'{to_dir}/ksk/{file}', 'w')
            for poly in ksk:
                for coef in poly:
                    fw.write('%x\n' % coef)
            fw.close()
        subprocess.run([f'rm', f'{to_dir}/ksk/temp.txt'])
    print()

def prepare_ksk_uram(from_dir, to_dir):
    for i in range(12):
        print(f'{HEAD} prepare uram_k{i+1} from {from_dir}')
        with open(f'{to_dir}/uram_k{i}.mem', 'w') as fw:
            dir_name = f'{from_dir}/ksk'
            # file = f'k{i+1}.txt'
            a = read_files(dir_name, i)
            a = pack_every_delta(a, 8)
            write_file(fw, a)
    print()

if __name__ == '__main__':
    assert(len(sys.argv) in [1, 2])
    if len(sys.argv) == 2:
        test_name = sys.argv[1]
        assert(test_name.startswith(f'test_'))
    else:
        test_name = 'test_row'

    # directory of test vector
    if 'stg' in test_name or 'row' in test_name: # partial test
        test_dir = '../../../tv/basic'
    else: # full test
        assert('full' in test_name)
        test_dir = '../../../tv/' + test_name.split('_')[2]

    # prepare ksk
    prepare_ksk_uram(test_dir, f'../../../sim/vcs')
