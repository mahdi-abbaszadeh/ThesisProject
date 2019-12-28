import subprocess

# global variables
result = []
dzn_filename = 'partitioning.dzn'

#******************
#******************
def dzn_gen( NUM_OF_NODES = -1,
            NUM_OF_PARTS = -1,
            MAX_PARTS_DIFF = -1,
            MAX_NET_WEIGHT = -1,
            MAX_PROCESS_METRIC = -1,
            nm = [],
            pm = [],
            n = []
            ):
            
    file = open(dzn_filename, 'w')
    
    L1 = [   'NUM_OF_NODES = '+str(NUM_OF_NODES)+';\n',
            'NUM_OF_PARTS = '+str(NUM_OF_PARTS)+';\n',
            'MAX_PARTS_DIFF = '+str(MAX_PARTS_DIFF)+';\n',
            'MAX_NET_WEIGHT = '+str(MAX_NET_WEIGHT)+';\n',
            'MAX_PROCESS_METRIC = '+str(MAX_PROCESS_METRIC)+';\n\n',
            'nodes_matrix = ['
        ]
        
    L2 = []
    for i in range(0, NUM_OF_NODES):
        L2.append('| ')
        for j in range(0, NUM_OF_NODES):
           L2.append(' '+str(nm[i][j])+',')
        L2.append('\n')
    L2.append(' |];\n\n')
    
    L3 = ['process_metric = [ ']
    for i in range(0, NUM_OF_NODES):
        L3.append(str(pm[i])+',\n')
    L3.append(' ];\n\n')
    
    L4 = ['next = [ ']
    for i in range(0, NUM_OF_NODES):
        L4.append('{')
        for j in n[i]:
            L4.append(str(j)+',')
        L4.append('},\n')
    L4.append('];\n\n')
            
            
    file.writelines(L1 + L2 + L3 + L4)
    file.close()
#******************
#******************
def run_cmd():
    IDE_PATH = 'export PATH=/Applications/MiniZincIDE.app/Contents/Resources:$PATH'
    COMPILE_CMD = 'minizinc --solver Gecode -o result.txt partitioning.mzn partitioning.dzn'
    
    CMD = IDE_PATH + '\n' + COMPILE_CMD
    
    subprocess.call(CMD, shell = True)
#******************
#******************
def str2char(word):
    return [char for char in word]
#******************
#******************
# nop = NUM OF PARTS
def output_parts(nop):
    partitions = []
    for i in range(0, nop):
        ltmp = []
        # we must add 1, because 0 index is "edges_between" var
        temp = str2char(result[i + 1])
        if (temp[0] == '{'):
            j = 0
            while (temp[j] != '}'):
                j = j + 1
                ltmp.append(int(temp[j], 10))
                j = j + 1
        else:
            start = int(temp[0], 10)
            end = int(temp[3], 10)
            for i in range(start, end + 1):
                ltmp.append(i)
        partitions.append(ltmp)
    return partitions
#******************
#******************
# read minizinc IDE output file
def read_res_file(fileName):
    with open(fileName, 'r') as f:
         return f.read().split('\n')
#******************
#******************
# nop = NUM OF PARTS
# non = NUM OF NODES
def output_schedule(nop, non):
    ltmp = []
    # start index in result
    # below is the reasons about why add this values to access to result
    # . 1 -> "edges_between" var
    # . nop -> skip to the number of partitions
    # . 1 -> "" var
    idx = 1 + nop + 1;
    for i in range(0, non):
        ltmp.append(int(result[i + idx], 10))
    return ltmp
#******************
#******************


#***********************************************************************
#                               M A I N
#***********************************************************************

nodes_matrix = [[ 0, 1, 2, 0, 1 ],
                [ 1, 0, 1, 0, 2 ],
                [ 2, 1, 0, 1, 4 ],
                [ 0, 0, 1, 0, 0 ],
                [ 1, 2, 4, 0, 0 ] ]
                
process_metric =[ 30,
                  40,
                  20,
                  10,
                  60 ]
                  
next = [ {2, 3},
         {3, 5},
         {4},
         {},
         {3} ]
         
dzn_gen(5, 3, 2, 10, 100, nodes_matrix, process_metric, next)
run_cmd()
result = read_res_file('result.txt')
parts = output_parts(3)
scheds = output_schedule(3, 5)

print(parts)
print(scheds)

#TODO i should check if there is no possible solution
#TODO also if we use "-a" which shows all solutions, what I have to do?
