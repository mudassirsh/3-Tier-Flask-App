# Nginx - Reverse Proxy

Proxy is of two types, Forward and Reverse. Both are same thing but in different directions. We need to identify who is the client and who is the server.

 **Forward Proxy**
In forward proxy, request is going out. Forward proxy is that where proxy is set on the outgoing traffic from the company network. <img align="right" width="300" height="250" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/9e6f233f-be27-4304-a287-ff1f961e8942" />
In corporate environment, in order to control employees access to certain websites, proxy server being used. Proxy server receives all the requests and stop the request if a blocked website.  i.e college computer denied access to adult sites. 


- Advantages of Proxy:
	1. Selectively send/block requests
	2. Log monitor requests
	3. Caching responses
	4. Webserver or receiver doesn’t know where the request is coming from. Proxy server will take the request with authentication and forward it on user’s behalf and receive back the response and the send it back to the customer.

**Reverse Proxy**  <img align="right" width="300" height="250" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/59279b8d-ba61-4b99-94db-b400e9b8d2d7" />

For server that request is coming in, this request is a reverse proxy.	Proxy server which is set at the front to receive all the incoming traffic is called reverse proxy. 

We setup the proxy server in front of these servers. This proxy is responsible for getting requests from the outside world and then make the right request to the right server and then get the response from the server and send that response to the right client. In this case, the client doesn’t know what the actual server is that’s handling the request.
- Advantages of Proxy:
    1. Security, DDOS attack prvention, Firewall, Block bots and hackers
    2. Caching 
    3. Load balancing
One common pattern of using reverse proxy at least in the context of microservices is an API gateway. 

