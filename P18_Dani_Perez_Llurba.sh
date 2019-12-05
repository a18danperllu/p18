#!/bin/bash
https://github.com/a18danperllu/p18/edit/master/P18_Dani_Perez_Llurba.sh

# Menu
function usage() {
cat <<EOF	
	Usage: ${0} [-drafh] USER [USERN]
	
	Opcions per a deshabilitar/eliminar un compte local de Linux:
	
		-d Elimina un compte(s) d'usuari. 
		-r Elimina el directori "/home" associat al compte(s) d'un usuari. 
		-a Crea un arxiu del directory "/home" associat al compte(s) d'un usuari.
		-f Deshabilita un usuari però no l'elimina.
		-h Menú d'ajuda.
	
	
EOF
exit 1
}

# Notificació de que s'ha d'executar l'script com a superusuari.
if [[ "${UID}" -ne 0 ]]
then
 	echo 'Per a poder executar aquest script has de ser root.'
   	exit 1
fi


#Si no es passen paràmetres, mostra el menú d'ajuda.
if [ $# -eq 0 ]; then
	usage
fi

# Options
while getopts ":d:r:a:f:h:" OPCIO
do
	case ${OPCIO} in
  
	d)# Eliminar compte d'usuari
		
		USER="${OPTARG}"
		echo -e " "
		userdel ${USER}
		
		if [ $? -eq 0 ]; then
			echo -e "S'ha eliminat l'usuari: ${USER}\n"
		else
			echo -e "No s'ha pogut eliminar l'usuari.\n"
		fi
		;;
      
	r)# Eliminar directori "/home" associat al compte(s) d'un usuari.
    
		USER="${OPTARG}"
		echo -e " "
		rm -r /home/${USER}
		
		if [ $? -eq 0 ]; then
			echo -e "S'ha eliminat el directori /home de l'usuari: ${USER} \n"
		else
			echo -e "No s'ha pogut eliminar el directori /home de l'usuari.\n"
		fi
		;;
      
	a)# Crear un arxiu del directori "/home" associat al compte(s) d'un usuari.
    
		USER="${OPTARG}"
		echo -e " "
		cp -r /home/${USER} /home/ausias/Documents/ASO/${USER}.bu
		
		if [ $? -eq 0 ]; then
			echo -e "S'ha realitzat una còpia de seguretat associada a l'usuari: ${USER}\n"
		else
			echo -e "No s'ha pogut realitzar la còpia de seguretat.\n"
		fi
		;;
      
	f) # Deshabilitar un usuari però sense eliminar-lo.
    
		USER="${OPTARG}"
		echo -e " "
		usermod -L ${USER}
		
		if [ $? -eq 0 ]; then
			echo -e "L'usuari ${USER} ha sigut deshabilitat.\n"
		else
			echo -e "No s'ha pogut deshabilitar l'usuari.\n"
		fi
		;;
		
	h)# Menú d'ajuda.
		
		USER="${OPTARG}"
		echo -e " "
	
		if [ $? -eq 0 ]; then
			usage
		fi
		;;
     
    # Missatges d'error.
    \?)
	echo -e "\n"
	echo -e "ERROR: Opció invàlida -$OPTARG\n"
	usage
	;;
    :)
    echo -e "\n"
	echo -e "ERROR: -$OPTARG requereix d'un argument.\n"
	;;
    *)
    echo -e "\n"
	echo -e "ERROR: Error no identificat.\n"
	usage
	;;
  esac
done

shift "$(( OPTIND - 1 ))"

