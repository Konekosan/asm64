#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Autor: Koneko, shellcode creator x64
import os

def main():
 print("\n\033[92m=======================\033[0m")
 print("\033[92m BINARY ASSEMBLE/DISASS \033[0m")
 print("\033[92m=======================\033[0m\n")

 file=raw_input("\033[94m[+] Entrez le nom de votre fichier (.asm): \033[0m\n\n")

 if os.path.isfile(file) == True:
  fileWe=file.split(".")

  if fileWe[0] == file:
   print("[-] Le fichier spécifié n'a pas d'extension")
   exit()

  if fileWe[1] != "asm":
   print("[-] Le fichier spécifié n'est pas en .asm")
   exit()

  else:
   compilation="nasm -felf64 "+file
   os.system(compilation)
   print("\n\033[92m[+] Compilation terminée.\033[0m")

   link="ld "+fileWe[0]+".o -o "+fileWe[0]
   os.system(link)
   print("\033[92m[+] Linkage terminé.\033[0m")

   os.system("rm "+fileWe[0]+".o")

   print("\033[92m[+] Préparation du shellcode ...\033[0m\n")

   hexa="for i in $(objdump -d "+fileWe[0]+" |grep \"^ \" |cut -f2); do echo -n ' '$i; done; echo"
   regex="for i in $(objdump -d "+fileWe[0]+" |grep \"^ \" |cut -f2); do echo -n '\\x'$i; done; echo"

   print("\033[93m[+]shellcode: \033[0m\n")
   os.system(hexa)
   os.system(regex)

   print("\n\033[94m[+] Disass Binary\033[0m\n")
   objdp = "objdump -d " + fileWe[0]
   os.system(objdp)

   print("\n\033[94m[+] Length Shellcode :\033[0m\n")
   hexaLen="for i in $(objdump -d "+fileWe[0]+" |grep \"^ \" |cut -f2); do echo -n $i; done; echo"
   print hexaLen
   lenShell = len(hexaLen)
   print("Length: ", lenShell/2)

 else:
  print("[-] Erreur le fichier specifié n'existe pas.")


if __name__== "__main__":
   main()
