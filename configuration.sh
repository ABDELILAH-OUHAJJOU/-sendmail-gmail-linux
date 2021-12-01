#!/bin/bash
configuration () {
configfile=/etc/ssmtp/ssmtp.conf

if [ -a ${configfile} ];then
                echo -e '\033[0;33m' "File ${configfile} exists"'\033[0m'
                echo 
                while :
                do
                    echo -e '\033[0;33m'"Do you want to edit it prese [Yes/No] and [V/v] or [View] to see content or [No/N] return :"'\033[0m' 
		            read ANSW
                    case $ANSW in
                        Y|y|yes|YES|Yes)
                            sensible-editor ${configfile}
                            ;;
                        N|n|no|NO|No)
                            sudo ./$0
                            break
                            ;;
                        V|v|view|View|VIEW)
                            cat ${configfile} | ccze -A 
                            ;;   
                        *)
                            echo -e '\033[0;31m' "Sorry, I don't understand" '\033[0m'
                            ;;
                    esac
                done
            else
                echo -e '\033[0;31m' "Enter your information:" '\033[0m'
                read -p "Enter you '(root)' name: " name 
                read -p "Enter gmail addresse AuthUser: " gmail
                read -sp "Password: " password
                echo 
                echo 
                echo -e "Your name (root) is: " '\033[1;32m' ${name} '\033[0m'
                echo -e "Your email addresse AuthUser is: " '\033[1;31m' ${gmail} '\033[0m'
                echo
                echo -e "If no correct press '\033[0;31m' ctrl+c '\033[0m' to exit and run it"
                echo
                echo -e "If you want to shake information use '\033[1;32m' ( cat ${configfile} ) '\033[0m' and edit if not correct."
                sleep 10 
                echo "root=${name}" >> ${configfile}
                echo "mailhub=smtp.gmail.com:465" >> ${configfile}
                SERVER="`hostname`"
                echo "hostname=${SERVER}" >> ${configfile}
                echo "FromLineOverride=YES" >> ${configfile}
                echo "AuthUser=${gmail}" >> ${configfile}
                echo "AuthPass=${password}" >> ${configfile}
                echo "UseTLS=YES" >> ${configfile}
            fi
}