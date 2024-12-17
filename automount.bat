@echo off

:: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

::  This script automates the mounting and unmounting of ISO files
::  for programs that require a CD to be present.
::  This assumes we are storing the ISO in the same folder as the
::  program's main executable.

::  To create a shortcut to run this batch file without displaying
::  any UI popups, we will need to install NirCmd, found here:
::    https://www.nirsoft.net/utils/nircmd.html
::  Right click > New > Shortcut > Type the location like so:
::    "X:\path\to\nircmd.exe" exec hide "X:\path\to\automount.bat"
::  To create a non-Steam game shortcut, we configure as follows:
::  TARGET: "X:\path\to\nircmd.exe"
::  START IN: "X:\path\to\game\folder\"
::  LAUNCH OPTIONS: exec hide "X:\path\to\automount.bat"

:: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

::  Stores location of root directory, CD image, main exe and disc
::  volume serial number as variables. These are the only sections
::  you will need to change yourself.
::  To find the serial number of our disc, we use the command:
::    > wmic logicaldisk get volumeserialnumber
::  This returns a list of serials, one for each available volume
::  in the computer. Run the command before & after mounting the
::  ISO manually and the extra one will be the one we want.

set ProgramDIR=X:\path\to\program\folder
set ProgramISO=%ProgramDIR%\iso.iso
set ProgramEXE=%ProgramDIR%\exe.exe
set DiscSerial=1A2B3C4D

::  Ensures CD has been mounted correctly by looping until drive
::  has been found.

:loop_mount
(wmic logicaldisk get volumeserialnumber | find "%DiscSerial%" > nul)^
 || powershell -command Mount-DiskImage -ImagePath '%ProgramISO%' > nul
(wmic logicaldisk get volumeserialnumber | find "%DiscSerial%" > nul)^
 || goto :loop_mount

::  Starts program and waits for it to close before continuing.

powershell -command Start-Process -Wait -NoNewWindow '%ProgramEXE%' > nul

::  Ensures CD has been unmounted correctly by looping until drive
::  is no longer found.

:loop_unmount
(wmic logicaldisk get volumeserialnumber | find "%DiscSerial%" > nul)^
 && powershell -command DisMount-DiskImage -ImagePath '%ProgramISO%' > nul
(wmic logicaldisk get volumeserialnumber | find "%DiscSerial%" > nul)^
 && goto :loop_unmount
