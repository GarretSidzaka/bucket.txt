#!/bin/bash
#BUCKET.SH
#DISCLAIMER: CANNOT BE HELD LIABLE FOR YOU RUNNING THIS ON YOUR DEVICE AND BRICKING IT.
#MORE DISCLAIMER: IF YOU THINK THIS SCRIPT MAKES ANDROID SECURE FOR YOU TO DO ILLEGAL THINGS, THINK AGAIN.
#THIS SCRIPT DOES NOT REMOVE CORE DEPENDANCIES AND YOU WOULD LIKELY BE TRACKED VIA THOSE.
#MOREOVER:
#BRUH DONT RUN THIS ON YOUR CELL PHONE, EVER.
#THIS IS JUST FOR THOSE KNOCKOFF/ALLWINNER TABLETS RUNNING ANDROID
#THIS WOULD BREAK YOUR PHONE REALLY BADLY.
#MUST HAVE android-tools OR WHATEVER IT IS THAT GIVES YOU ADB
#THIS IS A BASH SCRIPT (IT USES BASH ARRAYS), SO RUN IT WITH BASH:
#  ./bucket.sh          (normal run)
#  ./bucket.sh -d       (debug mode)
#  bash ./bucket.sh -d  (if not marked executable)
#-d IS DEBUG MODE: A DRY RUN THAT PRINTS EACH COMMAND (SET -X TRACING),
#UNINSTALLS NOTHING, AND DOES NOT REBOOT. USE IT TO PREVIEW SAFELY.
target_package_list=(
com.android.chrome
com.google.android.googlequicksearchbox
com.google.android.webview
com.google.android.apps.maps
com.google.android.youtube
com.google.android.apps.youtube.music
com.google.android.apps.youtube.kids
com.google.android.gm
com.google.android.calendar
com.google.android.contacts
com.google.android.keep
com.google.android.apps.docs
com.google.android.apps.photos
com.google.android.apps.googleassistant
com.google.android.apps.nbu.files
com.google.android.apps.tachyon
com.google.android.apps.books
com.google.android.videos
com.google.android.play.games
com.google.android.deskclock
com.google.android.inputmethod.latin
com.android.calculator2
com.android.camera2
com.android.soundrecorder
com.android.soundpicker
com.android.musicfx
com.android.htmlviewer
com.android.bookmarkprovider
com.android.providers.partnerbookmarks
com.google.android.printservice.recommendation
com.google.android.apps.kids.home
com.android.simappdialog
com.android.emergency
com.android.egg
com.android.vending
com.google.android.onetimeinitializer
com.google.android.setupwizard
com.google.android.apps.adm
com.google.android.as
com.google.android.as.oss
com.google.android.health.connect.backuprestore
com.google.android.healthconnect.controller
com.google.android.apps.wellbeing
com.google.android.apps.safetyhub
#ALLWINNER SPECIFIC PACKAGES
com.dajingtech.update
com.softwinner.update
com.softwinner.android.gmsintegration
com.softwinner.awlogsettings
com.softwinner.awsysteminfo
com.clock.pt1.keeptesting
com.djgd.testmode
com.softwinner.runin.res
com.softwinner.runin
com.softwinner.dragonatt
com.djgd.pdf
com.softwinner.videoplayer
com.softwinner.screenshot
com.softwinner.qrscanner
com.softwinner.timerswitch
)
DEBUG=0
if [ "$1" == "-d" ]; then
   DEBUG=1
   echo "DEBUG MODE: dry run. Nothing will be uninstalled and the device will NOT reboot."
   echo "Every command is printed (via 'set -x') so you can see exactly what a real run would do."
   set -x
fi

command -v adb || {
echo "adb not installed"
exit 1
}

if [ "$DEBUG" -eq 1 ]; then
   echo "============================"
   echo "CURRENTLY INSTALLED PACKAGES:"
   echo ""
   adb shell pm list packages
   echo "============================"
fi

for i in "${target_package_list[@]}"; do
   if [ "$DEBUG" -eq 1 ]; then
      echo "WOULD RUN: adb shell pm uninstall -k --user 0 $i"
   else
      echo -e "EXECUTING: adb shell pm uninstall -k --user 0 $i \nOUTPUT:"
      adb shell pm uninstall -k --user 0 "$i"
   fi
done

if [ "$DEBUG" -eq 1 ]; then
   set +x
   echo "============================"
   echo "DEBUG MODE COMPLETE. No changes were made. Re-run without -d to actually uninstall."
   exit 0
fi

read -p "Press enter to reboot target android device, or Control-C to end script now without reboot."
echo "Rebooting android device in 5 seconds"
sleep 5
adb shell reboot
exit 0
