#!/bin/bash

# Date limite (15 novembre)
LIMIT_DATE="2024-11-15"

# Récupérer la date actuelle
CURRENT_DATE=$(date +%Y-%m-%d) || exit 1
# Comparer les dates
if [[ "$CURRENT_DATE" < "$LIMIT_DATE" ]]; then
  # Bloquer l'accès en affichant un message et en fermant les sessions
  echo "Le système est verrouillé jusqu'au $LIMIT_DATE. Vous ne pouvez pas utiliser cet ordinateur pour le moment." | wall
  pkill -KILL -u $USER
  exit 1
fi

exit 0
