UnHTM( HTM ) {   ; Remove HTML formatting / Convert to ordinary text   by SKAN 19-Nov-2009
 Static HT,C=";" ; Forum Topic: www.autohotkey.com/forum/topic51342.html  Mod: 16-Sep-2010
 IfEqual,HT,,   SetEnv,HT, % "&aacutea&acirca&acute��&aelig��&agravea&amp&aringa&atildea&au"
 . "mla&bdquo?&brvbar|&bull?&ccedilc&cedil��&cent��&circ?&copy��&curren��&dagger��&dagger��&deg"
 . "��&divide��&eacutee&ecirce&egravee&eth��&eumle&euro��&fnof?&frac12��&frac14��&frac34��&gt>&h"
 . "ellip��&iacutei&icirci&iexcl��&igravei&iquest��&iumli&laquo��&ldquo��&lsaquo?&lsquo��&lt<&m"
 . "acr?&mdash?&micro��&middot��&nbsp &ndash?&not��&ntilden&oacuteo&ocirco&oelig��&ograveo&or"
 . "df��&ordm��&oslash��&otildeo&oumlo&para��&permil��&plusmn��&pound��&quot""&raquo��&rdquo��&reg"
 . "��&rsaquo?&rsquo��&sbquo?&scaron?&sect��&shy &sup1��&sup2��&sup3��&szlig��&thorn��&tilde?&tim"
 . "es��&trade��&uacuteu&ucircu&ugraveu&uml��&uumlu&yacutey&yen��&yumly"
 $ := RegExReplace( HTM,"<[^>]+>" )               ; Remove all tags between  "<" and ">"
 Loop, Parse, $, &`;                              ; Create a list of special characters
   L := "&" A_LoopField C, R .= (!(A_Index&1)) ? ( (!InStr(R,L,1)) ? L:"" ) : ""
 StringTrimRight, R, R, 1
 Loop, Parse, R , %C%                               ; Parse Special Characters
  If F := InStr( HT, L := A_LoopField )             ; Lookup HT Data
    StringReplace, $,$, %L%%C%, % SubStr( HT,F+StrLen(L), 1 ), All
  Else If ( SubStr( L,2,1)="#" )
    StringReplace, $, $, %L%%C%, % Chr(((SubStr(L,3,1)="x") ? "0" : "" ) SubStr(L,3)), All
Return RegExReplace( $, "(^\s*|\s*$)")            ; Remove leading/trailing white spaces
}

; unhtml.ahk - stdlib desired name
;
; StdLib compliant collection to convert HTML to Text
;
; Known Bugs: unHTML_StripEntities wont work for
; Unicode / UTF-8 Entities - These will stay intact
;
; v 1.3 / (a & w) Nov 2008 by derRaphael(at)oleco.net
;

; Syntax sugar for combined call of StripEntities & StripTags
unHTML(html){         
   Return unHTML_StripTags(unHTML_StripEntities(html))
}

; Removes HTML Tags frolm given text
unHTML_StripTags(txt){ ; v1 (w) by derRaphael Oct 2008
   Return RegExReplace(txt,"<[^>]+>","")
}

; Strips HTML entities out of given Text / No Unicode / UTF8 Entity support yet
unHTML_StripEntities(html){ ; v1.3.1 (w) by derRaphael Nov 2008
   Loop,
      if (RegExMatch(html,"&[a-zA-Z0-9#]+;",entity)) {
         n:=RegExReplace(unHTML_ConvertEntity2Number(entity),"[^\d]")
         if ((n>0) && (n<256)) {
            html := RegExReplace(html,"\Q" entity "\E",chr(n))
         }
      } else
         break
   return html
}

; Thx Jamey: http://www.autohotkey.com/forum/viewtopic.php?t=22522
; Rewrite by derRaphael v 1.3 / Nov 2008
unHTML_ConvertEntity2Number(sEntityName) {
   nNumber := -1   ;This will remain -1 if the entity name could not be translated.
   nStr := StrLen(sEntityName)

   ;Require the input format:  "& ... ;"
   if ((nStr < 3) || (SubStr(sEntityName, 1, 1) != "&") || (SubStr(sEntityName, 0) != ";"))
      return %nNumber%

   ;If the entity was given as its entity-number format, then return the number part.
   sEntityIdentifier := SubStr(sEntityName, 2, nStr-2)

   if sEntityIdentifier is integer
   {
      sEntityIdentifier := Round(sEntityIdentifier)   ;Not just can be interpreted as integer, but is!
      if (sEntityIdentifier >= 0)
         return %sEntityIdentifier%
      else
         return %nNumber%
   }

   ;If sEntityName really is a name-format entity, then find its number from the table below.
      entityList := "quot|34,apos|39,amp|38,lt|60,gt|62,nbsp|160,iexcl|161,cent|162,pound|163,curren|164,"
            . "yen|165,brvbar|166,sect|167,uml|168,copy|169,ordf|170,laquo|171,not|172,shy|173,reg|"
            . "174,macr|175,deg|176,plusmn|177,sup2|178,sup3|179,acute|180,micro|181,para|182,middo"
            . "t|183,cedil|184,sup1|185,ordm|186,raquo|187,frac14|188,frac12|189,frac34|190,iquest|"
            . "191,Agrave|192,Aacute|193,Acirc|194,Atilde|195,Auml|196,Aring|197,AElig|198,Ccedil|1"
            . "99,Egrave|200,Eacute|201,Ecirc|202,Euml|203,Igrave|204,Iacute|205,Icirc|206,Iuml|207"
            . ",ETH|208,Ntilde|209,Ograve|210,Oacute|211,Ocirc|212,Otilde|213,Ouml|214,times|215,Os"
            . "lash|216,Ugrave|217,Uacute|218,Ucirc|219,Uuml|220,Yacute|221,THORN|222,szlig|223,agr"
            . "ave|224,aacute|225,acirc|226,atilde|227,auml|228,aring|229,aelig|230,ccedil|231,egra"
            . "ve|232,eacute|233,ecirc|234,euml|235,igrave|236,iacute|237,icirc|238,iuml|239,eth|24"
            . "0,ntilde|241,ograve|242,oacute|243,ocirc|244,otilde|245,ouml|246,divide|247,oslash|2"
            . "48,ugrave|249,uacute|250,ucirc|251,uuml|252,yacute|253,thorn|254,yuml|255,OElig|338,"
            . "oelig|339,Scaron|352,scaron|353,Yuml|376,circ|710,tilde|732,ensp|8194,emsp|8195,thin"
            . "sp|8201,zwnj|8204,zwj|8205,lrm|8206,rlm|8207,ndash|8211,mdash|8212,lsquo|8216,rsquo|"
            . "8217,sbquo|8218,ldquo|8220,rdquo|8221,bdquo|8222,dagger|8224,Dagger|8225,hellip|8230"
            . ",permil|8240,lsaquo|8249,rsaquo|8250,euro|8364,trade|8482"

   Loop,Parse,entityList,`,
      if (RegExMatch(A_LoopField,"i)^" sEntityIdentifier "\|(?P<Number>\d+)", n))
         break

   return (nNumber!="") ? nNumber : sEntityIdentifier
}