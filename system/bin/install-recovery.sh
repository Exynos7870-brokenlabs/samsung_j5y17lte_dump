#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY:21020672:6d9fa7e1cfbe2e3bb00b9fe66966f7f40a94e5bd; then
  applypatch EMMC:/dev/block/platform/13540000.dwmmc0/by-name/BOOT:18563072:55c42aa56003312d9326d1cac0491810d242f532 EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY 6d9fa7e1cfbe2e3bb00b9fe66966f7f40a94e5bd 21020672 55c42aa56003312d9326d1cac0491810d242f532:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
