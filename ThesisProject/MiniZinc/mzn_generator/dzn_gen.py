
# name of .dzn output file
dzn_filename = 'partitioning.dzn'

#********************************
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
#********************************


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

