#!/bin/bash
#         __                      
#   __ _ / _|_ __ _____  ___   _  
#  / _` | |_| '__/ _ \ \/ / | | | 
# | (_| |  _| | | (_) >  <| |_| | 
#  \__, |_| |_|  \___/_/\_\\__, | 
#  |___/                   |___/  
#
# Tool Name     : GFROXY - Get Free Proxy
# Version       : 2.1
# Made w/       : BASH + Love <3
# Privilege by  : Schopath
# My Github     : https://github.com/panophan
# Contribute to : ZeroByte.ID (https://github.com/zerobyte-id)
# Website       : www.zerobyte.id / blog.zerobyte.id

### COLORING ###
GRN='\e[0;32m'
RED='\e[0;31m'
CLR='\e[0m'

GFRXDIR="$(pwd)/gfroxy-data"

if [[ ! -d ${GFRXDIR} ]];
then
	mkdir ${GFRXDIR}
fi
if [[ ! -d ${GFRXDIR} ]];
then
	echo -e "${RED}ERROR: Cannot make directory ${GFRXDIR}${CLR}"
	exit
fi

if [[ -z $(command -v curl) ]]
then
	echo -e "${RED}ERROR: Please install \"curl\" first!${CLR}"
	exit
fi

function GatherProxyCountryCode() {
        echo "AF|Afghanistan;AX|Aland Islands;AL|Albania;DZ|Algeria;AS|American Samoa;AD|Andorra;AO|Angola;AI|Anguilla;AQ|Antarctica;AG|Antigua And Barbuda;AR|Argentina;AM|Armenia;AW|Aruba;AU|Australia;AT|Austria;AZ|Azerbaijan;BS|Bahamas;BH|Bahrain;BD|Bangladesh;BB|Barbados;BY|Belarus;BE|Belgium;BZ|Belize;BJ|Benin;BM|Bermuda;BT|Bhutan;BO|Bolivia;BA|Bosnia And Herzegovina;BW|Botswana;BV|Bouvet Island;BR|Brazil;IO|British Indian Ocean Territory;BN|Brunei Darussalam;BG|Bulgaria;BF|Burkina Faso;BI|Burundi;KH|Cambodia;CM|Cameroon;CA|Canada;CV|Cape Verde;KY|Cayman Islands;CF|Central African Republic;TD|Chad;CL|Chile;CN|China;CX|Christmas Island;CC|Cocos (Keeling) Islands;CO|Colombia;KM|Comoros;CG|Congo;CD|Congo Democratic Republic;CK|Cook Islands;CR|Costa Rica;CI|Cote D\Ivoire;HR|Croatia;CU|Cuba;CY|Cyprus;CZ|Czech Republic;DK|Denmark;DJ|Djibouti;DM|Dominica;DO|Dominican Republic;EC|Ecuador;EG|Egypt;SV|El Salvador;GQ|Equatorial Guinea;ER|Eritrea;EE|Estonia;ET|Ethiopia;FK|Falkland Islands (Malvinas);FO|Faroe Islands;FJ|Fiji;FI|Finland;FR|France;GF|French Guiana;PF|French Polynesia;TF|French Southern Territories;GA|Gabon;GM|Gambia;GE|Georgia;DE|Germany;GH|Ghana;GI|Gibraltar;GR|Greece;GL|Greenland;GD|Grenada;GP|Guadeloupe;GU|Guam;GT|Guatemala;GG|Guernsey;GN|Guinea;GW|Guinea-Bissau;GY|Guyana;HT|Haiti;HM|Heard Island & Mcdonald Islands;VA|Holy See (Vatican City State);HN|Honduras;HK|Hong Kong;HU|Hungary;IS|Iceland;IN|India;ID|Indonesia;IR|Iran;IQ|Iraq;IE|Ireland;IM|Isle Of Man;IL|Israel;IT|Italy;JM|Jamaica;JP|Japan;JE|Jersey;JO|Jordan;KZ|Kazakhstan;KE|Kenya;KI|Kiribati;KR|Republic of Korea;KW|Kuwait;KG|Kyrgyzstan;LA|Lao People\s Democratic Republic;LV|Latvia;LB|Lebanon;LS|Lesotho;LR|Liberia;LY|Libyan Arab Jamahiriya;LI|Liechtenstein;LT|Lithuania;LU|Luxembourg;MO|Macao;MK|Macedonia;MG|Madagascar;MW|Malawi;MY|Malaysia;MV|Maldives;ML|Mali;MT|Malta;MH|Marshall Islands;MQ|Martinique;MR|Mauritania;MU|Mauritius;YT|Mayotte;MX|Mexico;FM|Micronesia Federated States Of;MD|Moldova;MC|Monaco;MN|Mongolia;ME|Montenegro;MS|Montserrat;MA|Morocco;MZ|Mozambique;MM|Myanmar;NA|Namibia;NR|Nauru;NP|Nepal;NL|Netherlands;AN|Netherlands Antilles;NC|New Caledonia;NZ|New Zealand;NI|Nicaragua;NE|Niger;NG|Nigeria;NU|Niue;NF|Norfolk Island;MP|Northern Mariana Islands;NO|Norway;OM|Oman;PK|Pakistan;PW|Palau;PS|Palestinian Territory Occupied;PA|Panama;PG|Papua New Guinea;PY|Paraguay;PE|Peru;PH|Philippines;PN|Pitcairn;PL|Poland;PT|Portugal;PR|Puerto Rico;QA|Qatar;RE|Reunion;RO|Romania;RU|Russia;RW|Rwanda;BL|Saint Barthelemy;SH|Saint Helena;KN|Saint Kitts And Nevis;LC|Saint Lucia;MF|Saint Martin;PM|Saint Pierre And Miquelon;VC|Saint Vincent And Grenadines;WS|Samoa;SM|San Marino;ST|Sao Tome And Principe;SA|Saudi Arabia;SN|Senegal;RS|Serbia;SC|Seychelles;SL|Sierra Leone;SG|Singapore;SK|Slovakia;SI|Slovenia;SB|Solomon Islands;SO|Somalia;ZA|South Africa;GS|South Georgia And Sandwich Isl.;ES|Spain;LK|Sri Lanka;SD|Sudan;SR|Suriname;SJ|Svalbard And Jan Mayen;SZ|Swaziland;SE|Sweden;CH|Switzerland;SY|Syrian Arab Republic;TW|Taiwan;TJ|Tajikistan;TZ|Tanzania;TH|Thailand;TL|Timor-Leste;TG|Togo;TK|Tokelau;TO|Tonga;TT|Trinidad And Tobago;TN|Tunisia;TR|Turkey;TM|Turkmenistan;TC|Turks And Caicos Islands;TV|Tuvalu;UG|Uganda;UA|Ukraine;AE|United Arab Emirates;GB|United Kingdom;US|United States;UM|United States Outlying Islands;UY|Uruguay;UZ|Uzbekistan;VU|Vanuatu;VE|Venezuela;VN|Vietnam;VG|Virgin Islands British;VI|Virgin Islands U.S.;WF|Wallis And Futuna;EH|Western Sahara;YE|Yemen;ZM|Zambia;ZW|Zimbabwe" | sed 's/;/\\\n/g' | sed 's/\\//g' | grep "${1}" | head -1
}

function ProxyCheck() {
	GRN='\e[0;32m'
	RED='\e[0;31m'
	CLR='\e[0m'

	PROXY="${1}"
	GFRXDIR="$(pwd)/gfroxy-data"

	PROXYCONN=$(curl --proxy ${PROXY} --connect-timeout 3 --max-time 3 -skL "https://raw.githubusercontent.com/zerobyte-id/gfroxy-bash/master/proxy_request" 2> /dev/null)
	if [[ $PROXYCONN =~ "GFROXY_-_PROXY_RESPONSE_200_OK" ]]
	then
		PROXY_FULL=$(cat ${GFRXDIR}/uncheckedproxies.list | grep "${PROXY}" | head -1)
		echo -e "${GRN}LIVE! ${PROXY_FULL}${CLR}"
		echo "${PROXY_FULL}" >> ${GFRXDIR}/proxies.live
	else
		echo -e "${RED}DIE: ${PROXY}${CLR}"
	fi
}

function GetProxy() {
	OPT_THREAD="${1}"
	GFRXDIR="$(pwd)/gfroxy-data"

	echo -ne "" > ${GFRXDIR}/proxylists.txt.tmp

	echo "INFO: Getting proxy from [free-proxy-list.net]..."
	curl -skL "https://free-proxy-list.net/" > ${GFRXDIR}/proxylists.txt.download
	cat ${GFRXDIR}/proxylists.txt.download | sed 's/<\/thead><tbody>/\n\n\n/g' | sed 's/<tr><td>/\n/g' | sed 's/<th>/\n/g' | grep ' ago' | sed 's/<\/td><td>/ /g' | awk '{print "["$3"] "$1":"$2}' | sed 's/<\/td><td//g' >> ${GFRXDIR}/proxylists.txt.tmp
	rm ${GFRXDIR}/proxylists.txt.download

	echo "INFO: Getting proxy from [gatherproxy.com]..."
	IFS=$'\n'
	for GTPROX in $(curl -s "http://www.gatherproxy.com/" | grep PROXY_IP)
	do
		PROXY_ADDR=$(echo ${GTPROX} | sed 's/,"/ \\\n/g' | sed 's/"/ /g' | grep 'PROXY_IP' | awk '{print $3}')
		PROXY_PORT=$(echo ${GTPROX} | sed 's/,"/ \\\n/g' | sed 's/"/ /g' | grep 'PROXY_PORT' | awk '{print $3}')
		PROXY_COUNTRY=$(GatherProxyCountryCode "`echo ${GTPROX} | sed 's/,"/ \\\n/g' | sed 's/"/ /g' | grep 'PROXY_COUNTRY' | sed 's|  [\]||g' | sed 's/ : /|/g'`" | awk -F '|' '{print $2}')
		if [[ -z ${PROXY_COUNTRY} ]]
		then
			PROXY_COUNTRY="UNK"
		fi
		PROXY_PORT=$(echo $((0x${PROXY_PORT})))
		echo "[${PROXY_COUNTRY}] ${PROXY_ADDR}:${PROXY_PORT}" >> ${GFRXDIR}/proxylists.txt.tmp 
	done

	echo "INFO: Getting proxy from [hidemyassproxylist.org]..."
	curl -s "http://www.hidemyassproxylist.org/" | sed 's/<\/td><\/tr><tr><td>/\\\n/g' | grep '<td>HTTP' | sed 's/<span class="flag-icon flag-icon-/ [/g' | sed 's/<\/td><td>/ /g' | awk '{print toupper($10)"] "$2":"$3}'  >> ${GFRXDIR}/proxylists.txt.tmp

	echo "INFO: Getting proxy from [us-proxy.org]..."
	curl -skL https://www.us-proxy.org/ > ${GFRXDIR}/proxylists.txt.download
	cat ${GFRXDIR}/proxylists.txt.download | sed 's/<\/thead><tbody>/\n\n\n/g' | sed 's/<tr><td>/\n/g' | sed 's/<th>/\n/g' | grep ' ago' | sed 's/<\/td><td>/ /g' | awk '{print "["$3"] "$1":"$2}' | sed 's/<\/td><td//g' >> ${GFRXDIR}/proxylists.txt.tmp
	rm ${GFRXDIR}/proxylists.txt.download

	if [[ -f ${GFRXDIR}/proxychecked.live ]]
	then
		cat ${GFRXDIR}/proxychecked.live >> ${GFRXDIR}/proxylists.txt.tmp
	fi

	cat ${GFRXDIR}/proxylists.txt.tmp | sort -nr | uniq | sed 's/\[\]/\[UNK\]/g' > ${GFRXDIR}/uncheckedproxies.list
	rm ${GFRXDIR}/proxylists.txt.tmp

	echo "INFO: You got $(cat ${GFRXDIR}/uncheckedproxies.list | wc -l) proxies (uncheck)"

	THREADS=${OPT_THREAD}
	(
		for PROXY in $(cat ${GFRXDIR}/uncheckedproxies.list | awk '{print $2}');
		do 
			((cthread=cthread%THREADS)); ((cthread++==0)) && wait
			ProxyCheck "${PROXY}" & 
		done
		wait
	)
	cat ${GFRXDIR}/proxies.live | sort -nr | uniq > ${GFRXDIR}/proxychecked.live
	rm ${GFRXDIR}/proxies.live
	rm ${GFRXDIR}/uncheckedproxies.list
	echo "INFO: Done! you got $(cat ${GFRXDIR}/proxychecked.live | wc -l) proxies"
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
		echo -ne ""
	elif [[ -f ${GFRXDIR}/proxychecked.live ]]
	then
		cp ${GFRXDIR}/proxychecked.live ${SAVETOFILE} 2> /dev/null
		if [[ ! -f ${SAVETOFILE} ]]
		then
			echo -e "${RED}ERROR: Cannot save to ${SAVETOFILE}${CLR}"
			exit
		fi
	fi
elif [[ ! -z ${SHOWLIST} ]];
then
	if [[ $(cat ${GFRXDIR}/proxychecked.live | wc -l) -lt 1 ]]
	then
		echo -e "${RED}ERROR: Proxy list is empty${CLR}"
		exit
	elif [[ ${SHOWLIST} == "proxy" ]]
	then
		cat ${GFRXDIR}/proxychecked.live | awk '{print $2}'
	elif [[ ${SHOWLIST} == "full" ]]
	then
		cat ${GFRXDIR}/proxychecked.live
	elif [[ ${SHOWLIST} == "random" ]]
	then
		echo "$(head -$((${RANDOM} % `wc -l < ${GFRXDIR}/proxychecked.live` + 1)) ${GFRXDIR}/proxychecked.live | tail -1 | awk '{print $2}')"
	fi
else
echo '      ____                                   '
echo '  ___|    |___       __          Version 2.1 '
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
