import os

# read the rest of the file
infile=open("output.txt", "r")
IP = ""

for line in infile:
    if "public_ip" in line:
        #print(line)
        checkIP = (next(infile).replace('"','').replace(',','').replace(' ',''))
        if checkIP[0].isdigit():
            checkIP = checkIP.rstrip()
            #print(checkIP)
            IP = IP + " " + checkIP

# removed the first character in the string, in this case a " "
#print(IP[1:])

# echo out ip cmd import os ?
os.system("./awsMigrationNginX.sh"+IP)  
#print("./awsMigrationDocker.sh"+IP)  

        
