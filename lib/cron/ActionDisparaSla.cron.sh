#!/bin/sh
Hora=`date +"%H"`
HoraFin=23
HoraInicio=6
if [ $HoraInicio -le $Hora ];then
  if [ $Hora -le $HoraFin ] ;then
       echo "La $Hora !"
       php73 /var/www/html/etr/sis_workflow/control/ActionSla.php
  fi
fi