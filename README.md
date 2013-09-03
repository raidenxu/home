Odin's UNIX/Linux Home Dir Setting
====


# Others

## term screen

    infocmp | sed -e 's/[sr]mcup=[^,]*,//' > /tmp/noaltscreen-terminfo
    $tic -o ~/.terminfo/ /tmp/noaltscreen-terminfo
