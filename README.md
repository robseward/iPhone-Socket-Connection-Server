README
========
This app receives data from an iPhone client connected via wireless. 

There's client code [here](https://github.com/robseward/iPhone-Socket-Connection-Client). 

And a blog post that includes a video [here](http://robseward.com/blog/2011/06/17/iphone-socket-connection-to-processing/).  
  
  
  
To Use:
-------
Configure the client in XCode by changing the line in TouchViewDrawController.m:

`#define kIpAddress @"192.168.1.103"`

Change the ip address address to that of your computer. Start up the server, start up the client, press the "reconnect" button, and you should see your touches translated to the computer screen. 