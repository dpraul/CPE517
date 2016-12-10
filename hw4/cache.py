from random import randint

def simulate(cache_size, ram_size, associativity, datablock, address_trace):
    hits = 0
    misses = 0

    no_blocks = cache_size / datablock / associativity
    cache = [[-10 for j in xrange(no_blocks)] for _ in xrange(2)]
    for i in xrange(ram_size):
        hit_flag = 0
        j = 0
        while j < no_blocks - 1:
            find = randint(0, address_trace)
            if find == cache[0][j]:
                hits += 1
                cache[0][j] = 0
                j = no_blocks  # end now
            else:
                hit_flag += 1
                j += 1  # keep looping
            
            if hit_flag == no_blocks - 1:
                misses += 1
                
                k = 0
                longest_age = 0
                age_location = 0
                wait_flag = 0
                
                while k < no_blocks - 1:
                    if cache[0][k] < 1:
                        cache[0][k] = find
                        cache[1][k] = 0
                        k = no_blocks  # end now
                    else:
                        cache[1][k] += 1
                        if cache[1][k] >= longest_age:
                            longest_age = cache[1][k]
                            age_location = k  # keep looping
                        k += 1
                    
                    if wait_flag == no_blocks - 1:
                        cache[0][age_location] = find
                        cache[1][age_location] = 0
    
    print('Hits: %s' % hits)
    print('Misses: %s' % misses)
    
if __name__ == '__main__':
    cache_size = input('Cache-Size (KB): ') * 1000
    ram_size = input('Physical Memory (MB): ') * 1000000
    associativity = input('Associativity: ')
    datablock = input('Cacheline/DataBlock (B): ')
    address_trace = input('Address trace size: ')
    print('Simulating (This is slow!)')
    simulate(cache_size, ram_size, associativity, datablock, address_trace)