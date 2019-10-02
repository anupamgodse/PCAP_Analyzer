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
            fw.write("\"" + conn[0] + "\" -- \"" + conn[1] + "\";\n")
    fw.write("}")
