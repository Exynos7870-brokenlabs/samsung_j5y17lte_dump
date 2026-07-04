#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY:24942880:6bee9ff54f6353f310dc0c41ed245eecfa772f2c; then
  applypatch EMMC:/dev/block/platform/13540000.dwmmc0/by-name/BOOT:19595552:9d631745436ddaf9837a2419160248025a33e51d EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY 6bee9ff54f6353f310dc0c41ed245eecfa772f2c 24942880 9d631745436ddaf9837a2419160248025a33e51d:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || echo 454 > /cache/fota/fota.status
else
  log -t recovery "Recovery image already installed"
fi

if [ -e /cache/recovery/command ] ; then
  PACKAGE_PATH=""
  SEARCH_COMMAND="--update_package"
  PATH_POS=16
  if [ -e '/system/bin/grep' ] ; then
    PACKAGE_PATH=`cat /cache/recovery/command | grep 'update_package'`
    PACKAGE_ORG_PATH=`cat /cache/recovery/command | grep 'update_org_package'`
    if [ "$PACKAGE_ORG_PATH" != "" ] ; then
      PACKAGE_PATH=$PACKAGE_ORG_PATH
      SEARCH_COMMAND="--update_org_package"
      PATH_POS=20
    fi
    if [ -e /cache/recovery/saved" ] ; then
      rm -rf /cache/recovery/saved
    fi

    if [ -e /data/.recovery/saved" ] ; then
      rm -rf /data/.recovery/saved
    fi
  fi
  if [ "$PACKAGE_PATH" != "" ] ; then
    for PACKAGE_LINE in $PACKAGE_PATH
    do
      if [ ${PACKAGE_LINE:0:$PATH_POS} == $SEARCH_COMMAND ] ; then
        break
      fi
    done
    let PATH_POS+=1
    PACKAGE_PATH=${PACKAGE_LINE:$PATH_POS}
    if [ "$PACKAGE_PATH" != "" ] ; then
      rm $PACKAGE_PATH
    fi
  fi
  if [ ${PACKAGE_PATH:0:5} == "/data" ] ; then
    echo $PACKAGE_PATH > /cache/fota/fota_path_command
    chown system:system /cache/fota/fota_path_command
  fi
  rm /cache/recovery/command
fi
