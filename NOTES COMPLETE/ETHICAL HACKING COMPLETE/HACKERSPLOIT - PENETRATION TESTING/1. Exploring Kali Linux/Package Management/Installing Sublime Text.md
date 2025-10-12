
1.  Download the GPG key and use apt-key to trust it

wget -qO - <https://download.sublimetext.com/sublimehq-pub.gpg> \| sudo apt-key add -

2.  Now that we have added this key to our trusted list, we can now add Sublime Text 3's repository to our apt sources list. A good practice is to have a separate file for every different community/3rd party repository that we add.

3.  Let's create a file named sublime-text.list in /etc/apt/sources.list.d and enter the repository information like so:
![image1](image1-3.png)

4.  And now use Nano or a text editor of your choice to add & save the Sublime Text 3 repository into this newly created file:
![image2](image2-2.png)

5.  After we have added this entry, we need to update apt to recognise this new entry -- this is done using the apt update command

6.  Once successfully updated, we can now proceed to install the software that we have trusted and added to apt using apt install sublime-text

**\# -----------------------------------------------Removing Packages:--------------------------------------------**

![image3](image3.png)

