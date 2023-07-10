#!/usr/bin/python3

x6_files = [
    '../../../tv/basic/stg2_a_out_x6.txt',
    '../../../tv/basic/stg2_b_out_x6.txt',
    '../../../tv/basic/stg3_a_in_x6.txt',
    '../../../tv/basic/stg3_b_in_x6.txt',
    '../../../tv/basic/stg3_a_out_x6.txt',
    '../../../tv/basic/stg3_b_out_x6.txt',
    '../../../tv/basic/stg4_a_in_x6.txt',
    '../../../tv/basic/stg4_b_in_x6.txt'
]

x6_repos = [0, 2, 4, 1, 3, 5]

if __name__ == '__main__':
    for f in x6_files:
        poly = [0] * 4096 * 6

        fp = open(f, 'r')
        for i in range(6):
            for j in range(4096):
                old_idx = i * 4096 + j
                new_idx = x6_repos[i] * 4096 + j
                poly[new_idx] = int(fp.readline(), 16)
        fp.close()

        fp = open(f, 'w')
        for coeff in poly:
            fp.write(f'{coeff:x}\n')
        fp.close()

