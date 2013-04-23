<?php
/*
  +----------------------------------------------------------------------+
  | Name:                                                                |
  +----------------------------------------------------------------------+
  | Comment:                                                             |
  +----------------------------------------------------------------------+
  | Author:Odin                                                          |
  +----------------------------------------------------------------------+
  | Created:2012-06-12 12:54:16                              |
  +----------------------------------------------------------------------+
  | Last-Modified:2013-04-18 10:58:41                        |
  +----------------------------------------------------------------------+
*/
function dspUrlRebuild($url,$params=array(),$chaos=false) {
    if (!empty($url)) {
        $url=html_entity_decode($url);
        $url_parts=parse_url($url);
        if (!empty($url_parts['scheme']) && !empty($url_parts['host'])) {
            $final_url=$url_parts['scheme'].'://'.$url_parts['host'];
            if (!empty($url_parts['port'])) $final_url.=':'.$url_parts['port'];
            if (empty($url_parts['path'])) {
                $final_url.='/';
            } else {
                $final_url.=$url_parts['path'];
            }
            $argv_string=empty($params)?'':http_build_query($params);
            if (!empty($url_parts['query'])) {
                if ($chaos===true) {
                    if (!empty($argv_string)) {
                        $final_url.='?'.$argv_string.'&'.$url_parts['query'];
                    } else {
                        $final_url.='?'.$url_parts['query'];
                    }
                } else {
                    $final_url.='?'.$url_parts['query'];
                    if (!empty($argv_string)) {
                        $final_url.='&'.$argv_string;
                    }
                }
            } elseif (!empty($argv_string)) {
                $final_url.='?'.$argv_string;
            }
            unset($argv_string);
            if (stristr($final_url,'_REACTSESSION_')) {
                $final_url=str_replace('_REACTSESSION_',urlencode($GLOBALS['reactSID']),$final_url);
            }
            return $final_url;
        } else {
            return false;
        }
    } else {
        return false;
    }
}
$url=$argv[1];
$params=array('a'=>'b');
$final_url=dspUrlRebuild($url,$params);
$dUrl=urldecode($final_url);
echo "[$url]-[$final_url]-[$dUrl]\n";
