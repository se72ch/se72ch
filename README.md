**INTRODUCTION:**

se72ch noob is a tool for automating reconnaissance tasks. It gathers information about a target domain, including subdomains and URLs, using OSINT tools like theHarvester, dirsearch, and httprobe. It verifies URL status codes and performs fuzzing to uncover hidden pages, enhancing security assessments and penetration testing engagements.

![image](https://github.com/se72ch/se72ch/assets/134131449/5bdd246e-c90a-402b-82ec-ec4133283ca8)

                                                                                                                                                                              
**SYNTAX:**

    [+] Usage: ./se72ch.sh [--live] [--fuzz] [-p/--parameters] 


    --live            : to check the status codes of discovered URLs.

    --fuzz            : to perform fuzzing on discovered URLs.

    --parameters / -p : to discovered website parameters.



**INSTALLATION:**

      ┌──(ali㉿ali)-[~]
      └─$  git clone https://github.com/Search829/se72ch.git
       
      ┌──(ali㉿ali)-[~]
      └─$ cd se72ch 
       
      ┌──(ali㉿ali)-[~]
      └─$ chmod +x requirements.sh
       
      ┌──(ali㉿ali)-[~]
      └─$ sudo ./requirements.sh
       
      ┌──(ali㉿ali)-[~]
      └─$ chmod +x se72ch.sh
       
      ┌──(ali㉿ali)-[~]
      └─$ ./se72ch.sh -h 

      
**EXSAMPLE**

      ┌──(ali㉿ali)-[~]
      └─$ ./se72ch.sh --live -fuzz -p  
![image](https://github.com/se72ch/se72ch/assets/134131449/7d9ad8f0-ccb6-444f-851e-75166b7e3a96)
![image](https://github.com/se72ch/se72ch/assets/134131449/82cf12c7-5c52-432b-8480-e5f89355f602)
![image](https://github.com/se72ch/se72ch/assets/134131449/0713102a-898b-4b27-b7f5-5e7be9636666)
![image](https://github.com/se72ch/se72ch/assets/134131449/f20be609-5d19-4e12-a0c9-a66ffa09f501)




**NOTES:**

1. enjoy a cup of coffee until the tool finishes working, it will take a little time.
2. your output  will save on the user's Desktop.
3. The tool will work on Kali without problems. Wait for the new version to work on other operating systems.
4. se72ch noob must not be run as *root*, Please change your user to anything else.
5. Use python 3.7+


   
**BUGS, COMMENTS, FEEDBACK**

1. Feel free to get in touch, at drabkahali7@gmail.com
2. Shoot my [LINKEDIN](https://www.linkedin.com/in/alialdrabkih/) with new ideas
