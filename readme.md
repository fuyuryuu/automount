This script automates the mounting and unmounting of ISO files for programs (such as many old games) that require a CD to be present, before launching said program.


INSTALLATION
---

- Download automount.bat to the root directory of the program you wish to use it with.
- Open the script in your preferred editor.
- Set the ```ProgramDIR``` variable to the root directory of the program.
- Set the ```ProgramISO``` variable to the name of the ISO file, making sure to keep the ```%ProgramDIR%\``` at the beginning.
- Set the ```ProgramEXE``` variable to the name of the main executable, making sure to keep the ```%ProgramDIR%\``` at the beginning.
- Set the ```DiscSerial``` variable to the volume serial number of the ISO. This will be an 8-digit hexadecimal number.  
      We can find the serial number of the ISO using the command:  
      ```wmic logicaldisk get volumeserialnumber```  
      This returns a list of serials, one for each available volume in the computer. Run the command before and after mounting the ISO manually, and the extra number in the list will be the one we want.  

Working Example:  

![Example of working variables](/assets/variables.png)

CREATING SHORTCUTS
---

If you wish to create a shortcut indistinguishable from the original shortcut to the program's executable, you will need to install Nir Sofer's NirCmd utility, [which you can find here](https://www.nirsoft.net/utils/nircmd.html). Without this, you will get a command prompt window popup when you run the batch script.

If creating a standard shortcut, the location field should contain ```X:\path\to\nircmd.exe exec hide "X:\path\to\automount.bat"``` replacing both paths respectively.  

Working Example:  

![Example of working Windows shortcut](/assets/lnk.png)

If creating a Steam shortcut, the TARGET field will contain ```X:\path\to\nircmd.exe```, the START IN will contain ```X:\path\to\game\folder\``` and the LAUNCH OPTIONS ```exec hide "X:\path\to\automount.bat"```  

Working Example:  

![Example of working Steam shortcut](/assets/steam.png)
