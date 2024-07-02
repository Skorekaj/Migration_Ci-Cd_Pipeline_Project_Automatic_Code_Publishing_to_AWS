terraform apply --auto-approve | tee output.txt

#Wait for Ec2 to become availible
read -p "Check Ec2 initialasation ans Status Check are Passed and OK before proceeding, press <Enter>" </dev/tty

# Reads the IP;s from the output.txt file and lists the IPs as input to the awsMigration script
python3 findip.py
