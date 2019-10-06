import sys

if __name__ == "__main__":
    ip_file = sys.argv[1] 

    ip_filename = sys.argv[1].split('/')[-1]
    op_file = "../data/" + ip_filename.split('.')[0] + ".dot"
    
    fr = open(ip_file, 'r')
    fw = open(op_file, 'w')

    fw.write("graph {\n")
    for line in fr:
        conn = line.split()
        if (len(conn) == 2):
            #identiy ICMP transactions
            icmp1 = conn[0].split(',')
            if len(icmp1) == 2:
                icmp2 = conn[1].split(',')
                fw.write("\"" + icmp1[0] + "\" -- \"" + icmp1[1] + "\";\n")
                fw.write("\"" + icmp2[0] + "\" -- \"" + icmp2[1] + "\";\n")
            else:
                fw.write("\"" + conn[0] + "\" -- \"" + conn[1] + "\";\n")

    fw.write("}")
