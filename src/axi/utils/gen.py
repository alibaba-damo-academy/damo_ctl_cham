import math

def Gen0(name, width_before, width_after, count):
    total_width = width_before * count
    s = []
    for i in range(count):
        end = total_width - (i+1) * width_before
        s.append(f'{name}[{end} +: {width_after}]')
    s = ',\n'.join(s)
    return s


def Gen1(name_o, name, width, count):
    log_count = math.ceil(math.log(count, 2))
    total_width = width * count
    s = []
    for i in range(count):
        end = total_width - (i+1) * width
        s.append(f'{log_count}\'d{i}: {name_o} = {name}[{end} +: {width}];')
    s = '\n'.join(s)
    return s


if __name__ == '__main__':
    with open('out.gen', 'w') as f:
        f.write(Gen0('i_ibuf_data', 64, 35, 8))
        f.write('\n\n')
        f.write(Gen1('odata', 'bram_dout', 35, 8))
        f.write('\n\n')

