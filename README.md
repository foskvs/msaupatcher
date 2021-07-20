# msaupatcher

Microsoft AutoUpdate patcher. Since Microsoft AutoUpdate searches for updates even if the checkbox is unselected, this tool forces the update agent to stop.

## Instructions

Install the script to ```/usr/local/bin``` with

```make install```

Uninstall it with

```make uninstall```

## Usage

For more information, run ```msaupatcher -h``` or ```msaupatcher --help```.

The script automatically disables Microsoft AutoUpdate if it's enabled (and vice-versa). Optional arguments are:

 - ```-e``` or ```--enable``` enables the automatic search for updates.
 - ```-d``` or ```--disable``` disables the automatic search for updates.
 - ```-s``` or ```--status``` checks the current status (enabled/disabled).
