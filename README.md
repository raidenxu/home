# Odin's UNIX/Linux Home Dir Setting

For Mac OS X, FreeBSD, Linux


## What's in it?
* [vimsetting]

## Others

### term screen

    infocmp | sed -e 's/[sr]mcup=[^,]*,//' > /tmp/noaltscreen-terminfo
    tic -o ~/.terminfo/ /tmp/noaltscreen-terminfo
