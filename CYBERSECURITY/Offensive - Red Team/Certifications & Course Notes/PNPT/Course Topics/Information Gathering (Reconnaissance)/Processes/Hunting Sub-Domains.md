---
Tools:
  - OWASP Amass
  - crt.sh
  - sublist3r
Select: Sub domain hunting
---
> [!important] We need to identify what sub-domains are out there

  

- Why are sub-domains important
    - You can find additional websites you can attack and hack
- ==Tools==
    - ==sublist3r==
        - How to Install
            
            ```Python
            apt install sublist3r 
            ```
            
        - basic Syntax Syntax
            
            ```Python
            sublist3r -d domain_name
            ```
            
        - results
            
              
            
    - ==[crt.sh](http://crt.sh)==
        
          
        
    - ==[OWASP amass](https://github.com/owasp-amass/amass)==
        
        https://github.com/owasp-amass/amass
        
        [https://owasp.org/www-project-amass/](https://owasp.org/www-project-amass/)
        
    - ==[tomnomnom probe](https://github.com/tomnomnom/httprobe)==
        - Give it a list of sub-domains
        - It will probe to see if active