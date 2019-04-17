### About GFROXY
This tool is used to search free proxy from proxy providers. Of course proxy is higher quality because proxy will be selected before taken. Good proxies are usually expensive! free is freedom solution!. Proxy lists is obtained from [free-proxy-list.net](free-proxy-list.net "free-proxy-list.net"), [gatherproxy.com](gatherproxy.com "gatherproxy.com"), [hidemyassproxylist.org](hidemyassproxylist.org "hidemyassproxylist.org"), [us-proxy.org](us-proxy.org "us-proxy.org"), and still counting.

![](https://raw.githubusercontent.com/zerobyte-id/gfroxy-bash/master/GFROXY.png)

### How to Install?
##### Install to Default Command
    git clone https://github.com/zerobyte-id/gfroxy-bash.git
    cd gfroxy-bash/
    cat gfroxy.bash > /usr/bin/gfroxy
    chmod +x /usr/bin/gfroxy
Run it:

    gfroxy

##### Direct Run
    git clone https://github.com/zerobyte-id/gfroxy-bash.git
    cd gfroxy-bash/
    chmod +x gfroxy.bash
Run it:

    ./gfroxy.bash

### How to Use?
##### Options:
-  -g [STRING] - (value: "proxy") This parameter is used to generate proxy list.
-  -o [FILE]   - (value: /path-to/file) This parameter is used to save proxy list to another file.
-  -t [INT]    - (value: 30) When checking proxies, you can change threads through this parameter. Bigger is faster (but takes a lot resources)
-  -l [STRING] - This parameter is used to show proxy list that you have obtained. The value that can be used as follows: "full" to display all proxies that you have obtained along with country-code, "random" to display one proxy randomly, and "proxy" to display all proxies without country-code.

##### Example:
To generate proxy:


    # gfroxy -g proxy
    # gfroxy -g proxy -t 30
    # gfroxy -g proxy -t 30 -o /path-to/filename

To show list:


    # gfroxy -l full
    # gfroxy -l proxy
    # gfroxy -l random

![](https://raw.githubusercontent.com/zerobyte-id/gfroxy-bash/master/Screenshots/GFROXY-Help.png)

-
### <<-EOF!
If you found bug/glitch you can contact us on [Facebook](https://fb.com/idzerobyte "Facebook"), and we will fix it, Thank You!
