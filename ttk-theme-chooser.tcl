#! /usr/bin/env wish

### Little window to select default ttk theme
### By Géballin - 2018
### Under GPL

package require fileutil

set X_RESOURCES_FILENAME {~/.Xresources}

proc on_select_theme {new_theme} {
    global theme_selected
    set theme_selected $new_theme
    destroy .frame
    ttk::setTheme $new_theme
    show_dialog
}

proc show_dialog {} {
    global theme_selected
    pack [ttk::frame .frame] -padx 5 -pady 5 -fill both
    grid [ttk::frame .frame.frm] -row 0 -column 0 -columnspan 3
    grid [ttk::label .frame.frm.themesLbl -text {Ttk theme: }] -row 0 -column 0
    grid [ttk::combobox .frame.frm.themesCmb -state readonly] -row 0 -column 1
    bind .frame.frm.themesCmb <<ComboboxSelected>> {on_select_theme [.frame.frm.themesCmb get]}
    
    .frame.frm.themesCmb configure -values [ttk::themes]
    .frame.frm.themesCmb set $theme_selected
    grid [ttk::button .frame.cancelBut -text "Cancel" -command "destroy ."] -row 1 -column 1
    grid [ttk::button .frame.set_defaultBut -default active -text "Set as default" -command {set_default_theme_to $theme_selected}] -row 1 -column 2
    focus .frame.frm.themesCmb
    image create photo applicationIcon -file [file join [file dirname [info script]] "tcl.png"];wm iconphoto . -default applicationIcon
    wm title . "TTK theme chooser"
    tkwait window .
}

proc actual_default_theme {} {
    global X_RESOURCES_FILENAME
    if {[file exists $X_RESOURCES_FILENAME]} {
	lmap line [split [fileutil::cat $X_RESOURCES_FILENAME] "\n"] {
	    if {[string first "TkTheme" $line] != -1} {
		return [lindex $line end]
	    }
	}
    }
    return "default"
}
set theme_selected [actual_default_theme]

proc set_default_theme_to {themename} {
    global X_RESOURCES_FILENAME
    global theme_selected
    if {[file exists $X_RESOURCES_FILENAME]} {
	set lines [lmap line [split [fileutil::cat $X_RESOURCES_FILENAME] "\n"] {
	    if {[string first "TkTheme" $line] == -1} {
		set line
	    }
	    continue
	}]
    }
    lappend lines "*TkTheme: $themename\n"
    fileutil::writeFile $X_RESOURCES_FILENAME [join $lines "\n"]
    exec xrdb [file normalize $X_RESOURCES_FILENAME]
    exit 0
}

if {$::argc > 0} {
    set_default_theme_to [lindex $::argv 0]
} else {
    package require Tk
    package require Ttk
    show_dialog
}
