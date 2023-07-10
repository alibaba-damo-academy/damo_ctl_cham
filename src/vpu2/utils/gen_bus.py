import sys

def GenOutput(pname, wname, io, width, count):
    total = width * count;
    gen = []
    for i in range(count):
        gen.append(f'wire [{width}-1:0] {wname}_{i};')
    for i in range(count):
        net1 = f'{wname}_{i}'
        net2 = f'{pname}[{i}*{width} +: {width}]'
        if io == 'i':
            gen.append(f'assign {net1} = {net2};')
        else:
            gen.append(f'assign {net2} = {net1};')
    return gen


if __name__ == '__main__':
    assert len(sys.argv) == 1 or len(sys.argv) == 6

    if len(sys.argv) == 1:
        fi = open('in.gin', 'r')
        fo = open('out.gen', 'w')
        for line in fi.readlines():
            pname, wname, io, width, count = line.strip().split(' ')
            gen = GenOutput(pname, wname, io, width, int(count))
            for line in gen:
                fo.write(line + '\n')
            fo.write('\n\n\n')

    else:
        pname = sys.argv[1] # port name
        wname = sys.argv[2] # wire name
        io = sys.argv[3]
        width = int(sys.argv[4])
        count = int(sys.argv[5])
        gen = GenOutput(pname, wname, io, width, count)
        for line in gen:
            print(line)

