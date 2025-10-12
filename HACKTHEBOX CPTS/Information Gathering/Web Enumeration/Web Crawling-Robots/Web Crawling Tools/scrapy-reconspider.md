---
icon: spider-web
---

# Scrapy (ReconSpider)

### <mark style="color:green;">Scrapy (ReconSpider)</mark>

We will leverage Scrapy and a custom spider tailored for reconnaissance on `inlanefreight.com`. If you are interested in more information on crawling/spidering techniques, refer to the "[Using Web Proxies](https://academy.hackthebox.com/module/details/110)" module, as it forms part of CBBH as well.

### Installing Scrapy

Before we begin, ensure you have Scrapy installed on your system. If you don't, you can easily install it using pip, the Python package installer:

```bash
pip3 install scrapy
pip3 install scrapy --break-system-packages
```

### Installing scrapy in Virtual Environment

```bash
┌─[root@parrot]─[/home/z3tssu/HTB]
└──╼ #python3 -m venv scrapy_env
┌─[root@parrot]─[/home/z3tssu/HTB]
└──╼ #source scrapy_env/bin/activate
(scrapy_env) ┌─[root@parrot]─[/home/z3tssu/HTB]
└──╼ #pip install scrapy
```

### Start Virtual Environment to Run ReconSpider

1. In the location where you create the virtual environment use the following command

```bash
source scrapy_env/bin/activate
```

This command will download and install Scrapy along with its dependencies, preparing your environment for building our spider.

### ReconSpider

First, run this command in your terminal to download the custom scrapy spider, `ReconSpider`, and extract it to the current working directory.

{% code overflow="wrap" %}
```bash
wget -O ReconSpider.zip https://academy.hackthebox.com/storage/modules/144/ReconSpider.v1.2.zip
unzip ReconSpider.zip 
```
{% endcode %}

With the files extracted, you can run `ReconSpider.py` using the following command:

```bash
python3 ReconSpider.py http://inlanefreight.com
```

Replace `inlanefreight.com` with the domain you want to spider. The spider will crawl the target and collect valuable information.

### results.json

After running `ReconSpider.py`, the data will be saved in a JSON file, `results.json`.&#x20;
