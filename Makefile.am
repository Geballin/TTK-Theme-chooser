bin_SCRIPTS = ttk-theme-chooser
ttk-theme-chooser:
	echo "#! /bin/sh" >$@
	echo '`dirname $$0`/../share/ttk-theme-chooser/ttk-theme-chooser.tcl' >>$@
	chmod ugo+x $@
appdir = $(prefix)/share/applications
app_DATA = ttk-theme-chooser.desktop
ttk-theme-chooser.desktop:
	echo "[Desktop Entry]" >$@
	echo "Name=TTK Theme chooser" >>$@
	echo "Comment=Change default TTK theme" >>$@
	echo "Exec=ttk-theme-chooser" >>$@
	echo  'Icon=$(pkgdatadir)/tcl.png' >>$@
	echo "Terminal=false" >>$@
	echo "Type=Application" >>$@
	echo "Categories=Settings;" >>$@
	echo "StartupNotify=true;" >>$@
	chmod 644 $@
CLEANFILES = ttk-theme-chooser ttk-theme-chooser.desktop
pkgdata_SCRIPTS = ttk-theme-chooser.tcl
dist_pkgdata_DATA = ttk-theme-chooser.tcl tcl.png README.md
# nobase_dist_pkgdata_DATA = $(supportdir_files)
UNINSTALLFILES =    ttk-theme-chooser.tcl tcl.png README.md
