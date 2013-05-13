<?php
/*
  +----------------------------------------------------------------------+
  | Name:                                                                |
  +----------------------------------------------------------------------+
  | Comment:                                                             |
  +----------------------------------------------------------------------+
  | Author:Odin                                                          |
  +----------------------------------------------------------------------+
  | Created:2013-05-09 12:22:38                              |
  +----------------------------------------------------------------------+
  | Last-Modified:2013-05-13 17:47:03                        |
  +----------------------------------------------------------------------+
*/
function findCookie($response) {
    $ret=array();

    do {
        if (empty($response)) {
            break;
        }
        $cookieinfo="^Set-Cookie:\s*([^;]*)";
        preg_match_all("/{$cookieinfo}/mi",$response,$mats);
        if (!empty($mats[1])) {
            foreach($mats[1] as $cookieStr) {
                $off=strpos($cookieStr,'=');
                $cKey=substr($cookieStr,0,$off);
                $cValue=substr($cookieStr,$off+1);
                //echo "$cKey:$cValue\n";
                $ret[$cKey]=$cValue;
            }
        }
    } while(false);

    return $ret;
}
function _findProperty($response,$name) {
    $ret='';

    do {
        if (empty($response)) {
            break;
        }
        $info="id=\"{$name}\".+value=\"(.+)\"";
        //echo $info."\n";
        preg_match("/{$info}/mi",$response,$mats);
        if (!empty($mats[1])) {
            $ret=$mats[1];
        }
    } while(false);

    return $ret;
}
//$content=file_get_contents('/tmp/login');
////preg_match_all('/(yyrq=\'20130510\'.+yysd="15">)/',$content,$mats);
//$view=_findProperty($content,'__VIEWSTATE');
//echo $view."\n";
//$env=_findProperty($content,'__EVENTVALIDATION');
//echo $env."\n";
$t=$argv[1];
if (preg_match("/^[0-9a-zA-Z]{4}$/",$t)) {
    echo "hi\n";
} else {
    echo "kao\n";
}
