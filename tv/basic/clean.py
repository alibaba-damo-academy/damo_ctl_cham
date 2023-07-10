#!/usr/bin/python3

import os, sys, subprocess

def clean(test_dir):
    dir_name = test_dir
    for file in os.listdir(dir_name):
        if file.startswith('stg0') or file.startswith('stg10') or file.startswith('ddr_in'):
            cmd = f'rm -f {dir_name}/{file}'
            subprocess.run(cmd.split())
            print(cmd)

if __name__ == '__main__':
    assert(len(sys.argv) == 1)
    clean(f'./')
