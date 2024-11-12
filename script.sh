#!/bin/bash

# PID du processus actuel
PID_COURANT=$$

echo "Ancêtres du processus PID $$ :"

# Boucle pour remonter chaque processus parent jusqu'au PID 1
while [ "$PID_COURANT" -ne 1 ]; do
    # Vérifie que le répertoire du processus existe
    if [ -f "/proc/$PID_COURANT/status" ]; then
        # Récupère le nom et le PID parent à partir des fichiers dans /proc
        NOM_PROCESSUS=$(grep "^Name:" /proc/$PID_COURANT/status | awk '{print $2}')
        echo "PID $PID_COURANT - $NOM_PROCESSUS"
        
        # Récupère le PID parent
        PID_COURANT=$(grep "^PPid:" /proc/$PID_COURANT/status | awk '{print $2}')
    else
        echo "Processus avec PID $PID_COURANT non trouvé."
        break
    fi
done

# Affiche le processus de PID 1
echo "PID 1 - $(cat /proc/1/comm 2>/dev/null)"
