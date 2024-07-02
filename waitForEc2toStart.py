import json
import os

i = 1
while i != "running":
    os.system("aws ec2 describe-instance-status --include-all-instances --filters 'Name=instance-state-code,Values=16' > instancerunning.txt ")  

    with open('instancerunning.txt', 'r') as fcc_file:
        fcc_data = json.load(fcc_file)

    test = fcc_data['InstanceStatuses']
    print(test)
    print("")
    print(test[0].values())
    print("")
    print(list(test[0].values())[2])

    print(i)
    i += 1
else:
    print("i is no longer less than 6")


