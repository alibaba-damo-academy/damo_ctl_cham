#!/usr/bin/python3

import os

func_name = f'vec_uram'
HEAD = f'\033[1m\033[92m[ {func_name:<12}]\033[0m'

if __name__ == '__main__':
    test_dir = '../../../tv/basic'
    sim_dir = '../../vcs'

    print(f'{HEAD} prepare uram_vec from {test_dir}')
    print()
    ft = open(os.path.join(test_dir, 'vec/stg2_vert1_x6.txt'), 'r')
    fs = open(os.path.join(sim_dir, 'uram_vec.mem'), 'w')

    while True:
        poly = []
        for i in range(4096):
            line = ft.readline()
            if not line:
                break
            poly.append(line)

        if len(poly) != 4096:
            break

        for i in range(4096):
            fs.write(poly[(i%8)*512 + (i//8)])

    ft.close()
    fs.close()
