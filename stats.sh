TODAY=`date +"%Y-%m-%d"`
YD=`date +"%Y-%m-%d" --date="-1 day"`
DB=`date +"%Y-%m-%d" --date="-2 day"`
curl -s tsocks http://www.beeeeer.org/user/ARHdqAGQQgrn2rARNPnm4T6Z2weRCHyCYQ | html2text >statsfile
head -30 statsfile
echo ""
echo -n "TOTAL XPM: `cat statsfile | awk '{print $5}' | sed '/ ^ $ / d' | awk '{sum +=$1} END {printf (sum)} '`"
echo ""
echo -n "TOTAL FEE: `cat statsfile | awk '{print $7}' | sed '/ ^ $ / d' | awk '{sum +=$1} END {printf (sum)} '`"
#
echo ""
echo ""
echo "XPM/D Totals"
echo -n "$TODAY XPM/D: `grep "$TODAY" statsfile | awk '{print $5}' | sed '/ ^ $ / d' | awk '{sum +=$1} END {printf (sum)} '`"
echo ""
echo -n "$TODAY SHARES/D: `grep "$TODAY" statsfile | wc -L`"
echo ""
echo ""
#
echo -n "$YD XPM/D: `grep "$YD" statsfile | awk '{print $5}' | sed '/ ^ $ / d' | awk '{sum +=$1} END {printf (sum)} '`"
echo ""
echo -n "$YD SHARES/D: `grep "$YD" statsfile | wc -L`"
echo ""
echo ""
#
echo -n "$DB XPM/D: `grep "$DB" statsfile | awk '{print $5}' | sed '/ ^ $ / d' | awk '{sum +=$1} END {printf (sum)} '`"
echo ""
echo -n "$DB SHARES/D: `grep "$DB" statsfile | wc -L`"
echo ""
