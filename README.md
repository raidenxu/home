# Odin's UNIX/Linux Home Dir Setting

For Mac OS X, FreeBSD, Linux Home dir


## What's in it?
* [vim]
* [files]
* [scripts]
* [sbin]

## Others

### term screen

    `infocmp | sed -e 's/[sr]mcup=[^,]*,//' > /tmp/noaltscreen-terminfo`
    `tic -o ~/.terminfo/ /tmp/noaltscreen-terminfo`
