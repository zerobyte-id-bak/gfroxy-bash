#!/bin/bash
#         __                      
#   __ _ / _|_ __ _____  ___   _  
#  / _` | |_| '__/ _ \ \/ / | | | 
# | (_| |  _| | | (_) >  <| |_| | 
#  \__, |_| |_|  \___/_/\_\\__, | 
#  |___/                   |___/  
#
# Tool Name     : GFROXY - Get Free Proxy
# Version       : 1.0
# Made w/       : BASH + Love <3
# Privilege by  : Schopath
# My Github     : https://github.com/panophan
# Contribute to : ZeroByte.ID (https://github.com/zerobyte-id)
# Website       : www.zerobyte.id / blog.zerobyte.id

### COLORING ###
GRN='\e[0;32m'
RED='\e[0;31m'
CLR='\e[0m'

if [[ -z $(command -v curl) ]]
then
	echo "ERROR: Please install \"curl\" first!"
	exit
fi

function GatherProxyCountryCode() {
        echo "AF|Afghanistan;AX|Aland Islands;AL|Albania;DZ|Algeria;AS|American Samoa;AD|Andorra;AO|Angola;AI|Anguilla;AQ|Antarctica;AG|Antigua And Barbuda;AR|Argentina;AM|Armenia;AW|Aruba;AU|Australia;AT|Austria;AZ|Azerbaijan;BS|Bahamas;BH|Bahrain;BD|Bangladesh;BB|Barbados;BY|Belarus;BE|Belgium;BZ|Belize;BJ|Benin;BM|Bermuda;BT|Bhutan;BO|Bolivia;BA|Bosnia And Herzegovina;BW|Botswana;BV|Bouvet Island;BR|Brazil;IO|British Indian Ocean Territory;BN|Brunei Darussalam;BG|Bulgaria;BF|Burkina Faso;BI|Burundi;KH|Cambodia;CM|Cameroon;CA|Canada;CV|Cape Verde;KY|Cayman Islands;CF|Central African Republic;TD|Chad;CL|Chile;CN|China;CX|Christmas Island;CC|Cocos (Keeling) Islands;CO|Colombia;KM|Comoros;CG|Congo;CD|Congo Democratic Republic;CK|Cook Islands;CR|Costa Rica;CI|Cote D\Ivoire;HR|Croatia;CU|Cuba;CY|Cyprus;CZ|Czech Republic;DK|Denmark;DJ|Djibouti;DM|Dominica;DO|Dominican Republic;EC|Ecuador;EG|Egypt;SV|El Salvador;GQ|Equatorial Guinea;ER|Eritrea;EE|Estonia;ET|Ethiopia;FK|Falkland Islands (Malvinas);FO|Faroe Islands;FJ|Fiji;FI|Finland;FR|France;GF|French Guiana;PF|French Polynesia;TF|French Southern Territories;GA|Gabon;GM|Gambia;GE|Georgia;DE|Germany;GH|Ghana;GI|Gibraltar;GR|Greece;GL|Greenland;GD|Grenada;GP|Guadeloupe;GU|Guam;GT|Guatemala;GG|Guernsey;GN|Guinea;GW|Guinea-Bissau;GY|Guyana;HT|Haiti;HM|Heard Island & Mcdonald Islands;VA|Holy See (Vatican City State);HN|Honduras;HK|Hong Kong;HU|Hungary;IS|Iceland;IN|India;ID|Indonesia;IR|Iran;IQ|Iraq;IE|Ireland;IM|Isle Of Man;IL|Israel;IT|Italy;JM|Jamaica;JP|Japan;JE|Jersey;JO|Jordan;KZ|Kazakhstan;KE|Kenya;KI|Kiribati;KR|Republic of Korea;KW|Kuwait;KG|Kyrgyzstan;LA|Lao People\s Democratic Republic;LV|Latvia;LB|Lebanon;LS|Lesotho;LR|Liberia;LY|Libyan Arab Jamahiriya;LI|Liechtenstein;LT|Lithuania;LU|Luxembourg;MO|Macao;MK|Macedonia;MG|Madagascar;MW|Malawi;MY|Malaysia;MV|Maldives;ML|Mali;MT|Malta;MH|Marshall Islands;MQ|Martinique;MR|Mauritania;MU|Mauritius;YT|Mayotte;MX|Mexico;FM|Micronesia Federated States Of;MD|Moldova;MC|Monaco;MN|Mongolia;ME|Montenegro;MS|Montserrat;MA|Morocco;MZ|Mozambique;MM|Myanmar;NA|Namibia;NR|Nauru;NP|Nepal;NL|Netherlands;AN|Netherlands Antilles;NC|New Caledonia;NZ|New Zealand;NI|Nicaragua;NE|Niger;NG|Nigeria;NU|Niue;NF|Norfolk Island;MP|Northern Mariana Islands;NO|Norway;OM|Oman;PK|Pakistan;PW|Palau;PS|Palestinian Territory Occupied;PA|Panama;PG|Papua New Guinea;PY|Paraguay;PE|Peru;PH|Philippines;PN|Pitcairn;PL|Poland;PT|Portugal;PR|Puerto Rico;QA|Qatar;RE|Reunion;RO|Romania;RU|Russia;RW|Rwanda;BL|Saint Barthelemy;SH|Saint Helena;KN|Saint Kitts And Nevis;LC|Saint Lucia;MF|Saint Martin;PM|Saint Pierre And Miquelon;VC|Saint Vincent And Grenadines;WS|Samoa;SM|San Marino;ST|Sao Tome And Principe;SA|Saudi Arabia;SN|Senegal;RS|Serbia;SC|Seychelles;SL|Sierra Leone;SG|Singapore;SK|Slovakia;SI|Slovenia;SB|Solomon Islands;SO|Somalia;ZA|South Africa;GS|South Georgia And Sandwich Isl.;ES|Spain;LK|Sri Lanka;SD|Sudan;SR|Suriname;SJ|Svalbard And Jan Mayen;SZ|Swaziland;SE|Sweden;CH|Switzerland;SY|Syrian Arab Republic;TW|Taiwan;TJ|Tajikistan;TZ|Tanzania;TH|Thailand;TL|Timor-Leste;TG|Togo;TK|Tokelau;TO|Tonga;TT|Trinidad And Tobago;TN|Tunisia;TR|Turkey;TM|Turkmenistan;TC|Turks And Caicos Islands;TV|Tuvalu;UG|Uganda;UA|Ukraine;AE|United Arab Emirates;GB|United Kingdom;US|United States;UM|United States Outlying Islands;UY|Uruguay;UZ|Uzbekistan;VU|Vanuatu;VE|Venezuela;VN|Vietnam;VG|Virgin Islands British;VI|Virgin Islands U.S.;WF|Wallis And Futuna;EH|Western Sahara;YE|Yemen;ZM|Zambia;ZW|Zimbabwe" | sed 's/;/\\\n/g' | sed 's/\\//g' | grep "${1}"$
}

function ProxyCheck() {
	GRN='\e[0;32m'
	RED='\e[0;31m'
	CLR='\e[0m'

	PROXY="$1"
	PROXYCONN=$(curl --proxy ${PROXY} --connect-timeout 3 --max-time 3 -sl "https://raw.githubusercontent.com/zerobyte-id/gfroxy-bash/master/proxy_request" 2> /dev/null)
	if [[ $PROXYCONN =~ "GFROXY_-_PROXY_RESPONSE_200_OK" ]]
	then
		PROXY_FULL=$(cat /tmp/uncheckedproxies.list | grep "${PROXY}" | head -1)
		echo -e "${GRN}LIVE! ${PROXY_FULL}${CLR}"
		echo "${PROXY_FULL}" >> /tmp/proxies.live
	else
		echo -e "${RED}DIE: ${PROXY}${CLR}"
	fi
}

function GetProxy() {
	OPT_THREAD="${1}"

	echo -ne "" > /tmp/proxylists.txt.tmp

	echo "INFO: Getting proxy from [free-proxy-list.net]..."
	wget -q https://free-proxy-list.net/ -O /tmp/proxylists.txt.download
	cat /tmp/proxylists.txt.download | sed 's/<\/thead><tbody>/\n\n\n/g' | sed 's/<tr><td>/\n/g' | sed 's/<th>/\n/g' | grep ' ago' | sed 's/<\/td><td>/ /g' | awk '{print "["$3"] "$1":"$2}' | sed 's/<\/td><td//g' >> /tmp/proxylists.txt.tmp
	rm /tmp/proxylists.txt.download

	echo "INFO: Getting proxy from [gatherproxy.com]..."
	IFS=$'\n'
	for GTPROX in $(curl -s "http://www.gatherproxy.com/" | grep PROXY_IP)
	do
		PROXY_ADDR=$(echo $GTPROX | grep -Po 'PROXY_IP":"\K.*?(?=")')
		PROXY_PORT=$(echo $GTPROX | grep -Po 'PROXY_PORT":"\K.*?(?=")')
		PROXY_COUNTRY=$(GatherProxyCountryCode "`echo $GTPROX | grep -Po 'PROXY_COUNTRY":"\K.*?(?=")'`" | awk -F '|' '{print $1}')
		PROXY_PORT=$(echo $((0x${PROXY_PORT})))
		echo "[${PROXY_COUNTRY}] ${PROXY_ADDR}:${PROXY_PORT}" >> /tmp/proxylists.txt.tmp
	done

	echo "INFO: Getting proxy from [hidemyassproxylist.org]..."
	curl -s "http://www.hidemyassproxylist.org/" | sed 's/<\/td><\/tr><tr><td>/\\\n/g' | grep '<td>HTTP' | sed 's/<span class="flag-icon flag-icon-/ [/g' | sed 's/<\/td><td>/ /g' | awk '{print toupper($10)"] "$2":"$3}'  >> /tmp/proxylists.txt.tmp

	echo "INFO: Getting proxy from [us-proxy.org]..."
	wget -q https://www.us-proxy.org/ -O /tmp/proxylists.txt.download
	cat /tmp/proxylists.txt.download | sed 's/<\/thead><tbody>/\n\n\n/g' | sed 's/<tr><td>/\n/g' | sed 's/<th>/\n/g' | grep ' ago' | sed 's/<\/td><td>/ /g' | awk '{print "["$3"] "$1":"$2}' | sed 's/<\/td><td//g' >> /tmp/proxylists.txt.tmp
	rm /tmp/proxylists.txt.download

	if [[ -f /tmp/proxychecked.live ]]
	then
		cat /tmp/proxychecked.live >> /tmp/proxylists.txt.tmp
	fi

	cat /tmp/proxylists.txt.tmp | sort -nr | uniq > /tmp/uncheckedproxies.list
	rm /tmp/proxylists.txt.tmp

	echo "INFO: You got $(cat /tmp/uncheckedproxies.list | wc -l) proxies (uncheck)"

	THREADS=${OPT_THREAD}
	(
		for PROXY in $(cat /tmp/uncheckedproxies.list | awk '{print $2}');
		do 
			((cthread=cthread%THREADS)); ((cthread++==0)) && wait
			ProxyCheck "${PROXY}" & 
		done
		wait
	)
	cat /tmp/proxies.live | sort -nr | uniq > /tmp/proxychecked.live
	rm /tmp/proxies.live
	echo "INFO: Done! you got $(cat /tmp/gfroxylist.txt | wc -l) proxies"
}

while getopts ":g:o:t:l:" ARG; do
	case $ARG in
		g)
			GENERATE_TRIGGER=${OPTARG}
			;;
		o)
			SAVETOFILE=${OPTARG}
			;;
		t)
			THREADS=${OPTARG}
			;;
		l)
			SHOWLIST=${OPTARG}
			;;
	esac
done
shift $(( OPTIND - 1 ))


if [[ ${GENERATE_TRIGGER} == "proxy" ]];
then
	if [[ -z ${THREADS} ]]
	then
		THREADS=10
	fi
	GetProxy ${THREADS}
	if [[ -z ${SAVETOFILE} ]]
	then
		echo -e "${RED}ERROR: Invalid argument${CLR}"
		exit
	fi
	if [[ -f /tmp/proxychecked.live ]]
	then
		cp /tmp/proxychecked.live ${SAVETOFILE} 2> /tmp/gfroxyerror
		if [[ ! -f ${SAVETOFILE} ]]
		then
			echo "${RED}ERROR: Cannot save to ${SAVETOFILE}${CLR}"
			rm /tmp/gfroxyerror
			exit
		fi
	fi
elif [[ ! -z ${SHOWLIST} ]];
then
	if [[ $(cat /tmp/proxychecked.live | wc -l) -lt 1 ]]
	then
		echo "${RED}ERROR: Proxy list is empty"
		exit
	elif [[ ${SHOWLIST} == "proxy" ]]
	then
		cat /tmp/proxychecked.live | awk '{print $2}'
	elif [[ ${SHOWLIST} == "full" ]]
	then
		cat /tmp/proxychecked.live
	elif [[ ${SHOWLIST} == "random" ]]
	then
		echo "$(head -$((${RANDOM} % `wc -l < /tmp/proxychecked.live` + 1)) /tmp/proxychecked.live | tail -1 | awk '{print $2}')"
	fi
else
echo '      ____                                   '
echo '  ___|    |___       __          Version 1.0 '
echo ' (____________)__ _ / _|_ __ _____  ___   _  '
echo '     /    \   / _` | |_| `__/ _ \ \/ / | | | '
echo '    | o  o | | (_| |  _| | | (_) >  <| |_| | '
echo '    |  __/ |  \__, |_| |_|  \___/_/\_\\__, | '
echo '     \____/   |___/                   |___/  '
echo ' Get Free Proxy Tool (BASH) - by ZeroByte.ID '
echo ''
echo ' ---------------------- Options : ----------------------'
cat << EOF
 -g [STRING] - (value: "proxy") This parameter is used 
               to generate proxy list.
 
 -o [FILE]   - (value: /path-to/file) This parameter is used 
               to save proxy list to another file.
 
 -t [INT]    - (value: 30) When checking proxies, you can
               change threads through this parameter.
               Bigger is faster (but takes a lot resources)

 -l [STRING] - This parameter is used to show proxy list that
               you have obtained. The value that can be used
               as follows:
               "full" to display all proxies that
               you have obtained along with country-code
               "random" to display one proxy randomly
               "proxy" to display all proxies without country
               code.
EOF
fi
