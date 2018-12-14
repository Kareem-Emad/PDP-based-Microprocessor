import numpy as np
import re


f=open("input.txt", "r")
contents =f.readlines()


decoded_instructions = []
def strip_line(line):
    while ', ' in line or  ' ,' in line:
        line = line.replace(', ',',')
        line = line.replace(' ,',',')

    while '  ' in line:
        line = line.replace('  ',' ')
    return line.replace('\r','').replace('\t','').replace('\n','').split(';')[0].lower()
def load_vars(contents):
    hashmap = {}
    i=0
    for line in contents:
        line = strip_line(line)
        if('define' not in line ):
            continue
        i = i+1
        line = line.replace('define','').replace(' ','')
        if(  '-' not in line[1:]):
            hashmap[line[0]]= int(line[1:])
        else:
            print( line[1:])
            hashmap[line[0]]= abs(int(   line[1:].split('-')[1]  )  ) + 2**15
    return hashmap
def update_vars_addresses(var_hash):
    count = 0
    for i in var_hash:
        count = count + 1
        var_hash[i] = count + len(decoded_instructions)-1
    return var_hash
def load_labels(contents):
    hashmap = {}
    i = 0
    for line in contents:
        line = strip_line(line)
        if(':'  in line ):
            line = line.replace(':','').replace(' ','')
            hashmap[line]=i
        i = i +1
    return hashmap


def decode_operand(operand):
    if(re.search('@[a-z]+\(r[0-7]\)',operand)):
        #print("{0:b}".format(int(operand[operand.find('r')+1])))
        #print("indexed indirect")

        return 0,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "111",operand[operand.find('@')+1]

    if(re.search('@-\(r[0-7]\)',operand)):
        #print(operand[operand.find('r')+1])
        #print("auto decrement indirect")
        return 1,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "110"

    if(re.search('@\(r[0-7]\)[+]',operand)):
        #print(operand[operand.find('r')+1])
        #print("auto increment indirect")
        return 2,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "101"

    if(re.search('@r[0-7]',operand)):
        #print(operand[operand.find('r')+1])
        #print("register mode indirect")
        return 3,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "100"


    if(re.search('[a-z|1-9]+\(r[0-7]\)',operand)):
       #indexed indirect
        #print(operand[operand.find('r')+1])
        #print("indexed ")
        return  4,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "011"

    if(re.search('-\(r[0-7]\)',operand)):
        #print(operand[operand.find('r')+1])
        #print("auto decrement ")
        return 5,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "010"

    if(re.search('\(r[0-7]\)[+]',operand)):
        #print(operand[operand.find('r')+1])
        #print("auto increment ")
        return 6,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "001"

    if(re.search('r[0-7]',operand)):
        #print(operand[operand.find('r')+1])
        #print("register mode ")
        return 7,"{0:03b}".format(int(operand[operand.find('r')+1]))+ "000"


    return -1

def process_instruction(instruction,variables,labels,instruction_number):
    instruction = strip_line(instruction.lower())

    instruction,op_typ = detect_instruction_type(instruction)
    #2 op instruction
    if(op_typ == 0):
        operands = instruction.split(' ')[1].split(',')
        decoded = instruction.split(' ')[0]
        word_first_operand = ""
        word_second_operand = ""
        if(decode_operand(operands[0])!= -1 ):
            decoded_1st = decode_operand(operands[0])
            if(len(decoded_1st) == 3 ):
                #print(variables[decoded_1st[2]])
                word_first_operand= variables[decoded_1st[2]]
            #print(decoded_1st[1])
            decoded = decoded +decoded_1st[1]

        else:
            #if it's addressing a variable
            if(operands[0] in variables):
                #place x(r7)+ code instead
                #print(instruction.split(' ')[0]+"111001")
                decoded = decoded + "111011"

                #place address of var in next mem location
                #print( "{0:b}".format(variables[operands[0]] ) )
                #add variables symbol to replace later
                word_first_operand =operands[0]
            else:
                #first operand can be immediate
                #(r7)+
                #print(instruction.split(' ')[0]+"111001")
                decoded = decoded + "111001"
                #put that in the next line
                word_first_operand = "{0:016b}".format(int(operands[0].split('#')[1]))
                #print(int(operands[0].split('#')[1]))



        if(decode_operand(operands[1])!= -1 ):
            decoded_2nd = decode_operand(operands[1])
            if(len(decoded_2nd) == 3 ):
                #print(variables[decoded_2nd[2]])
                word_second_operand = variables[decoded_2nd[2]]
            #print(decoded_2nd[1])
            decoded = decoded +decoded_2nd[1]
        else:
            #if it's addressing a variable
            if(operands[1] in variables):
                #place x(r7)+ code instead
                #print(instruction.split(' ')[0]+"111001")
                decoded = decoded + "111011"

                #place address of var in next mem location
                #print( "{0:b}".format(variables[ operands[1]  ] ))
                #add symbol to replace later
                word_second_operand = operands[1]
            else:
                #first operand cannot be immediate
                print("invalid ya 3m :v")

        decoded_instructions.append(decoded)
        if(word_first_operand != ""):
            decoded_instructions.append(word_first_operand)
        if(word_second_operand != ""):
            decoded_instructions.append(word_second_operand)


    #1 op instruction
    if(op_typ == 1):
        if(decode_operand( instruction.split(' ')[1])!= -1 ):
            #print(decode_operand( instruction.split(' ')[1])[1])
            decoded_instructions.append(instruction.split(' ')[0]+decode_operand( instruction.split(' ')[1])[1] + "00000")
            return

        #if it's addressing a variable
        if(instruction.split(' ')[1] in variables):
            #place x(r7)+ code instead
            #print(instruction.split(' ')[0]+"111001")
            decoded_instructions.append(instruction.split(' ')[0]+"111011"+"00000")
            #place address of var in next mem location
            #print( "{0:b}".format(variables[instruction.split(' ')[1]]) )
            #add variable symbol to replace later
            decoded_instructions.append(instruction.split(' ')[1])
        else:
            #one operand cannot be immediate
            #consider jsr
            decoded_instructions.append(instruction.split(' ')[0]+"00000000000")
            #print("invalid ya 3m :v")
            decoded_instructions.append( "{0:016b}".format(int(instruction.split('#')[1])))



    #branch instruction
    if(op_typ == 2):
        while '  ' in instruction:
            instruction = instruction.replace('  ',' ')
        #address = labels[instruction.split(' ')[1]]
        #address = "{0:b}".format(address-instruction_number)
        #print( instruction.split(' ')[0]  + str(address) )
        # add label of code for now to replace later
        encoded_label = ":"+ instruction.split(' ')[1] +":"+str(instruction_number)
        decoded_instructions.append(instruction.split(' ')[0]  + encoded_label)
    #no op instruction
    if(op_typ == 3):
        decoded_instructions.append(instruction + "0000000")
        #print(instruction)


def detect_instruction_type(instruction):
    instruction = instruction.lower()
    instructions_2op = {"mov":"0000","add":"0001","adc":"0010",
                            "sub":"0011","sbc":"0100","and":"0101" ,"xnor":"0111","or":"0110","cmp":"1000"}
    instruction,state =  replace_and_check(instruction,instructions_2op)
    if(state):
        return instruction,0
    #################################
    instructions_1op = {"inc":"10010","dec":"10011","clr":"10100",
                            "inv":"10101","lsr":"10110","ror":"10111","jsr":"11101",
                        "rrc":"11000","asr":"11001","lsl":"11010","rol":"11011","rlc":"11100"}
    instruction,state =  replace_and_check(instruction,instructions_1op)
    if(state):
        return instruction,1
    #################################
    instructions_branch = {"br":"1111000","beq":"1111001","bne":"1111010",
                            "blo":"1111011","bls":"1111100","bhi":"1111101","bhs":"1111110"}
    instruction,state =  replace_and_check(instruction,instructions_branch)
    if(state):
        return instruction,2
    #################################
    instructions_noop = {"nop":"111111101","hlt":"111111100","rts":"111111110","iret":"111111111"}
    instruction,state =  replace_and_check(instruction,instructions_noop)
    if(state):
        return instruction,3

    return "undefined",-1

def replace_and_check(instruction,replace_set):
    saved_instruction = instruction
    for i in replace_set:
        instruction = instruction.replace(i,replace_set[i])
    return instruction,saved_instruction != instruction


def decode(contents):
    i=-1
    var_hash =  load_vars(contents)
    labels_hash = load_labels(contents)
    for line in contents:
        if ":" in line:
            lbl = strip_line(line).split(":")[0]
            labels_hash[lbl] = len(decoded_instructions)
        i = i+1
        process_instruction(line, var_hash ,labels_hash,len(decoded_instructions))
    print(var_hash)
    for i in var_hash:
        decoded_instructions.append("{0:016b}".format(var_hash[i]))
    var_hash =  update_vars_addresses(var_hash)
    print(var_hash)
    for i in range(len(decoded_instructions)):
        for va in var_hash:
            decoded_instructions[i] = decoded_instructions[i].replace(va,"{0:016b}".format((var_hash[va])))
        if(len(decoded_instructions[i].split(":"))==3):
            label = labels_hash[ decoded_instructions[i].split(':')[1] ]
            label = int(label)
            current_pc = int( decoded_instructions[i].split(':')[2] )
            offset = label-current_pc
            if(offset < 0):
                offset = abs(offset) + 256
            decoded_instructions[i] =  decoded_instructions[i].split(':')[0] + "{0:09b}".format(offset)
            #print(label-current_pc)


    f=open("output.mem", "w")
    for inst in decoded_instructions:
        f.write(inst+'\n')

decode(contents)
