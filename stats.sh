#!/bin/bash
 
##########################################
#                                        #
# Simple statistics for beeeeer.org      #
# by fenix79                             #
# xpm:APiBoeLUpDSdyZNZ1SrttbVHRPrGLGeyMn #
#                                        #
##########################################
 
if [ -z $1 ]
then
   echo "usage: ./stat YOUR_ADDRESS [Number days to display]"
   exit -1
fi
 
if [ -z $2 ]
then
   dtd=1
else
   dtd=$2
fi
 
 
function line {
   printf "|"
for (( j=0; j<$1; j++ ))
do
   printf "-"
done
printf "|\n"
 
}
curl -s http://www.beeeeer.org/user/$1 |  sed 's/<br\/>/\n/g' | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | egrep "^>\s[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}\sreward"  >/tmp/statsfile
 
#curl -s http://www.beeeeer.org/user/$1 |  sed 's/<br\/>/\n/g' | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | egrep "^>\s[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}\sreward" |grep @  | awk '{print$2" "$5}' | sed '/^$/d'  >/tmp/statsfilepaid
 
 
 
line 40
for (( i=0; i<$dtd; i++ ))
do
   day=`date +"%Y-%m-%d" --date="-$i day"`
   value=`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d' | grep $day| awk '{sum+=$2}END{if (sum != NULL) printf("%.5f", sum); else printf("0.00000")}'`
   vpaid=`cat /tmp/statsfile | grep @ | awk '{print$2" "$5}' | sed '/^$/d' | grep $day| awk '{sum+=$2}END{if (sum != NULL) printf("%.5f", sum); else printf("0.00000")}'`
   share=`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d' | grep $day| wc -l`
   chain7=`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d' | grep $day| awk '{if ($2 <= 0.01) c7+=1  }END{if (c7 != NULL) printf(c7); else printf("0")}'`
   chain8=`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d'| grep $day| awk '{if ($2 <= 0.1 && $2 > 0.01) c8+=1  }END{if (c8 != NULL) printf(c8); else printf("0")}'`
   chain9=`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d' | grep $day| awk '{if ($2 <= 0.52 && $2 > 0.1) c9+=1  }END{if (c9 != NULL) printf(c9); else printf("0")}'`
   block=`cat /tmp/statsfile  | grep -v @ | awk '{print$2" "$5}' | sed '/^$/d'| grep $day| awk '{if ($2 < 1.0 && $2 > 0.52) blk+=1  }END{if (blk != NULL) printf(blk);else printf("0")}'`
   printf "|%-40s|\n" "               $day"
   line 40
   printf "|%s | %28s|\n" "xpm value" "$value"
   printf "|%s | %28s|\n" "xpm paid " "$vpaid"
   printf "|%s | %28s|\n" "shares   " "$share"
   printf "|%s | %28s|\n" "7-chains " "$chain7"
   printf "|%s | %28s|\n" "8-chains " "$chain8"
   printf "|%s | %28s|\n" "9-chains " "$chain9"
   printf "|%s | %28s|\n" "block    " "$block"
   line 40
done
printf "|%-9s | %28s|\n" "SUM" "`cat /tmp/statsfile | grep -v @ | awk '{print$2" "$5}' | awk '{sum+=$2}END{printf ("%.5f", sum)}'`"
printf "|%-9s | %28s|\n" "PAID" "`cat /tmp/statsfile | grep  @ | awk '{print$2" "$5}' | sed '/^$/d'| awk '{sum+=$2}END{printf ("%.5f", sum)}'`"
printf "|%s | %28s|\n" "share    " "`cat /tmp/statsfile | wc -l`"
line 40
