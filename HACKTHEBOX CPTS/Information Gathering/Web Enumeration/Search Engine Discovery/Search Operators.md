
---

## **Operator Reference Table**

|**Operator**|**Description**|**Example**|**Example Description**|
|---|---|---|---|
|**`site:`**|Restrict results to a specific website or domain.|`site:example.com`|Lists all indexed pages from `example.com`.|
|**`inurl:`**|Search for a keyword in URLs.|`inurl:login`|Finds pages with "login" in their URL.|
|**`filetype:`**|Search for files of a certain format.|`filetype:pdf`|Finds PDF files indexed by Google.|
|**`intitle:`**|Search for keywords in the page title.|`intitle:"confidential report"`|Finds pages titled "confidential report".|
|**`intext:` / `inbody:`**|Search for keywords in the body content.|`intext:"password reset"`|Finds pages mentioning "password reset".|
|**`cache:`**|View cached versions of pages.|`cache:example.com`|Displays Google’s cached copy of the site.|
|**`link:`**|Find pages linking to a given site.|`link:example.com`|Finds all sites linking to `example.com`.|
|**`related:`**|Discover similar or related websites.|`related:example.com`|Lists websites similar to `example.com`.|
|**`info:`**|Get a summary about a webpage.|`info:example.com`|Retrieves indexed info on the target domain.|
|**`define:`**|Look up definitions of words/phrases.|`define:phishing`|Gets definitions for "phishing".|
|**`numrange:`**|Search for numbers within a specific range.|`site:example.com numrange:1000-2000`|Finds pages with numbers between 1000 and 2000.|
|**`allintext:`**|Finds pages with **all** specified words in body text.|`allintext:admin password reset`|Returns pages with "admin" and "password reset".|
|**`allinurl:`**|Finds pages with **all** specified words in URLs.|`allinurl:admin panel`|Returns URLs containing "admin" and "panel".|
|**`allintitle:`**|Finds pages with **all** specified words in the title.|`allintitle:confidential report 2023`|Finds pages with those keywords in their title.|
|**`AND`**|Combine multiple conditions.|`site:example.com AND inurl:login`|Finds login pages specifically on `example.com`.|
|**`OR`**|Broaden searches with multiple options.|`"linux" OR "ubuntu" OR "debian"`|Finds pages mentioning Linux, Ubuntu, or Debian.|
|**`NOT`**|Exclude terms from results.|`site:bank.com NOT inurl:login`|Pages from `bank.com` excluding login URLs.|
|**`*` (wildcard)**|Use as a placeholder for unknown words.|`site:socialnetwork.com filetype:pdf user* manual`|Finds PDFs like "user guide", "user handbook", etc.|
|**`..` (range)**|Specify a numeric range.|`site:ecommerce.com "price" 100..500`|Finds items priced between 100 and 500.|
|**`" "` (quotes)**|Search for an exact phrase.|`"information security policy"`|Finds exact matches for that phrase.|
|**`-` (minus)**|Exclude terms from search results.|`site:news.com -inurl:sports`|Finds news articles excluding sports pages.|
