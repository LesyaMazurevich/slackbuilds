
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Most patches are from Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.90-plasma_konsole.patch
# Force kdm and kdm_greet to be hardened
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.4-kdm-harden.patch
# 441062: packagekit tools do not show icons correctly on KDE
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.6.80-krdb.patch
zcat ${SB_PATCHDIR}/kdebase-workspace-4.2.85-klipper-url.patch.gz | patch -p1 -E --backup --verbose
# 434824: KDE4 System Settings - No Method To Enter Administrative Mode
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.4.90-rootprivs.patch
# show the remaining time in the battery plasmoid's popup (as in 4.2) (#515166)
# currently requires backport from pre-4.3.80 trunk (Patch100)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.90-battery-plasmoid-showremainingtime.patch
# allow adding a "Leave..." button which brings up the complete shutdown dialog
# to the classic menu (as in KDE <= 4.2.x); the default is still the upstream
# default Leave submenu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.80-classicmenu-logout.patch
# kubuntu kudos! bulletproof-X bits ripped out
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.1-kdm_plymouth081.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.4.92-xsession_errors_O_APPEND.patch
# support the widgetStyle4 hack in the Qt KDE platform plugin
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.3.98-platformplugin-widgetstyle4.patch
# revert patch adding broken browser launcher
# https://projects.kde.org/projects/kde/kde-workspace/repository/revisions/2bbbbdd8fe5a38ae27bab44c9515b2ba78f75277
# https://bugzilla.redhat.com/show_bug.cgi?id=747982
# https://bugs.kde.org/show_bug.cgi?id=284628
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.3-bz\#747982-launchers.patch 
# HALsectomy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.80-no_HAL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.90-no_HAL2.patch

# plasmaclock displayEvents=false default, one more item to avoid
# starting akonadi by default
# FIXME/TODO: implement this via config to plasma javascript somehow?
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-displayEvents_default.patch

# Mandriva
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.5.71-notify_color_changes.patch

# add org.kde.ktp-presence applet to default systray
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.2-systray_org.kde.ktp-presence.patch

# upstreamable patches:
# "keyboard stops working", https://bugs.kde.org/show_bug.cgi?id=171685#c135
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.90-kde\#171685.patch

# use /etc/login.defs to define a 'system' account instead of hard-coding 500 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.2-bz\#732830-login.patch

# kdm overwrites ~/.Xauthority with wrong SELinux context on logout
# http://bugzilla.redhat.com/567914
# http://bugs.kde.org/242065
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.95-kdm_xauth.patch

# don't modify font settings on load (without explicit save)
# http://bugs.kde.org/105797
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kcm_fonts_dont_change_on_load.patch

# support BUILD_KCM_RANDR (default ON) option
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.2-BUILD_KCM_RANDR.patch

# avoid conflict between kcm_colors 4 and plasma-desktop 5
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.16-colorschemes-kde4.patch

if [ "${SB_SYSTEMD}" = "YES" ] ;then
  # add support for automatic multi-seat provided by systemd using existing reserve seats in KDM
  # needs having ServerCmd=/usr/lib/systemd/systemd-multi-seat-x set in /etc/kde/kdm/kdmrc
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.1-kdm-logind-multiseat.patch
  # pam/systemd bogosity: kdm restart/shutdown does not work
  # http://bugzilla.redhat.com/796969
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.0-bug796969.patch
fi

# use backlight actual_brightness interface
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.0-backlight_actual_brightness.patch

# https://bugs.kde.org/show_bug.cgi?id=330773#c5
# bbcukmet: update to BBC's new json-based search and modified xml
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.7-weather-fix-bbcukmet.patch
# https://bugs.kde.org/show_bug.cgi?id=330773#c6
# bbcukmet: handle cases where min. or max. temperatures are not reported
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.7-weather-fix-bbcukmet-temp.patch
# https://bugs.kde.org/show_bug.cgi?id=330773#c16
# bbcukmet: fix typo in the condition->icon matching ("clar sky" -> "clear sky")
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.7-weather-fix-bbcukmet-clear-sky.patch
# https://bugs.kde.org/show_bug.cgi?id=332392
# bbcukmet: fix a crash (#1079296/kde#332392) and improve error handling
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.7-weather-fix-bbcukmet-crash-kde\#332392.patch

### ROSA
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.4-fontconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.3-fix-kcmkdm-locale.patch

## upstream patches

## trunk patches

# Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/terminate-server.patch

# Set Chinforinfula defaults
patch -p0 -E --backup -z .classicmenudefs --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.0-classicmenu-defaults.patch

# Add /usr/share/gtk-2.0/gtkrc to GTK2_RC_FILES environment variable
patch -p0 -E --backup -z .gtkrc --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.2-add-gtkrc-path.patch

set +e +o pipefail
