#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Autor: Koneko, shellcode creator x64
import os

def main():

 file=raw_input("Entrez le nom de votre fichier (.asm): \n")

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
   print("[+] Compilation terminée.")

   link="ld "+fileWe[0]+".o -o "+fileWe[0]
   os.system(link)
   print("[+] Linkage terminé.")

   os.system("rm "+fileWe[0]+".o")

   print("[+] Préparation du shellcode ...\n")

   regex="for i in $(objdump -d "+fileWe[0]+" |grep \"^ \" |cut -f2); do echo -n '\\x'$i; done; echo"

   print("shellcode:")
   print("<<< $(python -c 'print \"")
   os.system(regex)
   print("\"')")

 else:
  print("[-] Erreur le fichier specifié n'existe pas.")


if __name__== "__main__":
   main()
