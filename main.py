########################
#   TomcatTec startup  #
#   written by t0mcat  #
########################
#                      #
# FAQ in the README.md #
#                      #
########################


####################ARGS#######################
icon_name = "server-icon.png"
motd = "&fWhite Market Server"
join_msg = ""
max_players = 120
show_extra_files = True
###############################################















































































# please do not touch the code below! it is all the code that 
# modifies the files for the server to work properly.

import os, time
os.system("clear")
if not "/nix/store/na2wyfsvfmj077imiyaf4swlhqls1w7s-nginx-1.20.1/bin" in os.environ["PATH"]:
  os.environ["PATH"] = open("PATH", "r").read()
if "SERVERIPHERE" in open("main.html", "r").read() and os.environ['REPL_OWNER'] != "T0MCAT":
  text = open("main.html", "r").read().replace("SERVERIPHERE", f"wss://{os.environ['REPL_SLUG'].lower()       }.{os.environ['REPL_OWNER']}.repl.co/i")
  open("main.html", "w").write(text)
def ttcf(fname):
  return "java/tomcattec_command/"+fname
file = open(ttcf("defconfig.yml"), "r").read()
file = file.replace("servericonhere", icon_name)
file = file.replace("servermotdhere", motd)
if join_msg == "":
  file = file.replace("joinmsgenabledhere", "false")
else:
  file = file.replace("joinmsghere", join_msg)
  file = file.replace("joinmsgenabledhere", "true")
file = file.replace("maxplayershere", str(max_players))
if show_extra_files == False:
  open(".replit", "w").write(open(ttcf("def.replit"), "r").read().replace("datahere", open(ttcf("defdata.replit"), "r").read()))
else:
  open(".replit", "w").write(open(ttcf("def.replit"), "r").read().replace("datahere", ""))
brand = " "+open(ttcf("brand"), "r").read()+" "
print(f"{brand:#^60}")
if brand != " TomcatTEC ":
  print(f"{' Source code by T0MCAT ':#^60}")
print("#"*60+"\n")
print(f"To join, use this URL:\nwss://{os.environ['REPL_SLUG'].lower()}.{os.environ['REPL_OWNER'].lower()}.repl.co/i\n")

os.system("clear")
print(f"{brand:#^60}")
if brand != " TomcatTEC ":
  print(f"{' Source code by T0MCAT ':#^60}")
print("#"*60+"\n")
open("java/bungee_command/config.yml", "w").write(file)
os.system("bash srvr.sh")