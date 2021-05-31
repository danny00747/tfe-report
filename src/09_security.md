Chapter VI : Security
=====================

## Spring Security

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=What is Spring Security ?,coltitle=white, fonttitle=\bfseries]

Spring Security is a powerful and highly customizable authentication and access-control framework. 
It is the de-facto standard for securing Spring-based applications.  \newline

Spring Security is a framework that focuses on providing both authentication and authorization to Java applications. 
Like all Spring projects, the real power of Spring Security is found in how easily it can be extended to meet custom 
requirements.

\rightline{{\rm --- From spring.io}}

\end{tcolorbox}


### Authentication 

\begin{figure}[H]
\centering
\caption{Spring Security Authentication Process}
\includegraphics[scale=1.25]{imgs/spring-secu.png}
\rightline{{\rm --- From Spring Security in Action Book}}
\end{figure}

Figure 7 demonstrates steps that executed to authenticate a user on the backend level. Obviously there is a lot of things 
going on under the hood during the authenticating process, but the details of the latter are out of scope 
of this report.

But it's important to note that upon a successful authentication, a JSON Web Token (JWT[^6]) with a validity of 72h
is sent to the user as shown in figure 8. 

\begin{figure}[H]
\centering
\caption{JWT Authentication Process}
\includegraphics[scale=0.45]{imgs/auth-success.png}
\rightline{{\rm --- From toptal.com}}
\end{figure}


## Role-based Access Control - RBAC

**Role-based Access Control**, is a mechanism that restricts an application access to users 
using their roles, privileges and permissions.

To limit what a customer can do, the latter has to be authenticated through a set of credentials verification process. 
Once successfully authenticated, the customer's role is retrieved from the HTTP Authorization header.

Within this application, roles are created for various user types (e.g., admin, user and anonymous). 
The permission to perform certain transactions or access a particular route, a specific role is needed. 
For instance, a user with a role of an `admin` is granted the permission to create, update, read, and 
delete any profile, whereas a user with a role of a `user` is given access to read & update their own profile.

\begin{figure}[H]
\centering
\caption{Spring Security Authorization Process}
\includegraphics[scale=1.3]{imgs/spring-access.png}
\rightline{{\rm --- From Spring Security in Action Book}}
\end{figure}

Step 4 shown in figure 9 might sometimes fail so in the effort to make the application more user-friendly, 
a custom authorization failure handler class was created to deal with users trying to access forbidden routes. 


\begin{figure}[H]
\centering
\caption{Authorization Fail Message}
\includegraphics[scale=0.39]{imgs/403-msg.jpeg}
\end{figure}

Figure 10 shows an authenticated user with no proper authorization trying to read all customers. Only a user with 
role of an `admin` is allowed to read all customers stored in the database. 

## Open Web Application Security Project - OWASP

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

The Open Web Application Security Project (**OWASP**) is an online community that produces freely-available articles, 
methodologies, documentation, tools, and technologies in the field of web application security.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```
### Sensitive Data Exposure

As the name implies, this security threat occurs when the web application does not adequately protect 
sensitive information like session tokens, emails, passwords, credit card information, location, health data,
or any other similar crucial data whose leak can be critical for the customer.

   - **Precaution Taken Against Sensitive Data Exposure**

First, I needed to determine what data the application collects that could be considered sensitive. After a thorough 
study on that matter, information like email addresses, phone numbers, personal address, and passwords should all be 
considered sensitive information. One way to defend against attackers gaining access to sensitive data is through 
thorough review of the application code and environment.

The following are some precautions that were taken to mitigate this attack :

   1. **Passwords are hashed using strong adaptive and salted hashing functions**.


```{.java caption="Password Encoder"}

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }

```


To achieve that we used a Spring Security's PasswordEncoder whose implementation uses BCrypt strong hashing functions. 
Bcrypt allows developers to choose the value of saltRounds. The higher this number is, the longer it takes a 
machine to compute the hash associated with the password.

Having that, it has to be small enough to avoid slowing down the application during the registration or 
authentification process. By default, the saltRounds value is 10, and that's the one that was chosen. It's good enough.

   2. **Website only available via HTTPS**.

If a website accepts a connection through HTTP and redirects to HTTPS, visitors may initially communicate with 
the non-encrypted version of the site before being redirected, if, for example, the visitor types 
`http://rent-vehicle.herokuapp.com` or even just `rent-vehicle.herokuapp.com`. This creates an opportunity for 
a man-in-the-middle attack. The redirect could be exploited to direct visitors to a malicious site instead 
of the secure version of the site.

We added the HTTP Strict-Transport-Security header that informs the browser that it should never load a 
site using HTTP and should automatically convert all attempts to access the site using HTTP to HTTPS requests 
instead. Once a browser sees this header, it will only visit the site over HTTPS for the next 365 days:


```{.java caption="Strict-Transport-Security Header"}

@Override
public void configure(HttpSecurity http) throws Exception {
    http
        .headers()
            .hsts()
                .includeSubdomains(true)
                .maxAge(Duration.ofDays(365));
}

```

> For the moment the site is deployed on Heroku so out of the box the site is already in HTTPS, but this header 
> added was added in case future developers choose another hosting platform other than Heroku.

### Referrer Policy

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=What's a referrer ?,coltitle=white, fonttitle=\bfseries]

The Referrer-Policy HTTP header controls how much referrer information (sent via the Referer header) should
be included with requests. 

For example, if you click a link on \textbf{\emph{https://rent-vehicle.herokuapp.com/index.html}}
that takes you to \textbf{\emph{https://www.ephec.be}}, Ephec’s servers will see 
Referer: \textbf{\emph{https://rent-vehicle.herokuapp.com}}. This can have privacy implications.

\end{tcolorbox}


   - **The referrer problem**

If you are visiting a site that knows your identity (i.e. any site you're logged into), then
this site may receive referrer URLs of other pages on the web that you have visited.
For example, you may visit a web page about a particular medical condition, sites may associate your identity 
with having visited that particular medical webpage.

   - **How was this fixed ?**

A Referrer-Policy header with a directive of `strict-origin-when-cross-origin` was added on the backend server to 
control what information is sent through the Referer header. This referer header indicates where the inbound visitor
came from, but there are cases where a developer may want to control or restrict the amount of information 
present in this header like the path or even whether the header is sent at all.

Here is an example :

| Source                         | Destination                     | Referrer                | 
|--------------------------------|---------------------------------|-------------------------|
| https://rent-vehicle.be/blog1  | https://facebook.com            | https://rent-vehicle.be |
| https://rent-vehicle.be/blog1  | http://facebook.com             | NULL                    |   
| https://rent-vehicle.be/blog1  | http://rent-vehicle.be/blog2    | NULL                    |
| https://rent-vehicle.be/blog1  | https://rent-vehicle.be/blog2   | Source                  | 
       
Table: Referrer Policy

```{.java caption="Referrer Policy"}

 @Override
 public void configure(HttpSecurity http) throws Exception {
    http
        .headers()
            .referrerPolicy(
                ReferrerPolicyHeaderWriter
                    .ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN)
 }

```


### Strict Transport Security

   - **The attack**

HTTPS is a secure protocol. HTTP, by contrast, is not. HTTP's users are vulnerable to person-in-the-middle attacks and 
nothing sent is encrypted. I like to think of insecure HTTP as “anything goes”.

   - **The header**

As explained above the Strict-Transport-Security HTTP header tells browsers to stick with HTTPS and never visit the insecure 
HTTP version. Once a browser sees this header, it will only visit the site over HTTPS for the next 365 days.

::: tip

See Listing 9: Strict-Transport-Security Header

:::

### X Frame Options

   - **The attack**

The attacker wants the end user to click on something the latter actually does not want to click on, but they may hide a button 
behind something else then trick the user into clicking that button. Clickjacking can be used to get you to click on 
anything you don’t want to. These things include unintentional endorsements on social networks,
clicking advertisements etc...

   - **The header**

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=What is X-Frame-Options ?,coltitle=white, fonttitle=\bfseries]

The X-Frame-Options HTTP response header can be used to indicate whether a browser should be allowed to render a 
page in a <frame>, <iframe>, <embed> or <object>. Sites can use this to avoid click-jacking attacks, by ensuring 
that their content is not embedded into other sites. \newline

\rightline{{\rm --- From developer.mozilla.org}}

\end{tcolorbox}

When browsers load iframes, they’ll check the value of the X-Frame-Options header and abort loading if it’s not allowed.
The header has three options, but the one that was chosen is `X-Frame-Options: DENY`


```{.java caption="X-Frame-Options"}

 @Override
 public void configure(HttpSecurity http) throws Exception {
    http
       .headers()
           .frameOptions()
               .deny()
}

```

\pagebreak

### Insufficient Logging And Monitoring

To detect easily why & when the website was/is down. An **uptimerobot[^7]** monitor was set up to send a message 
to the admin just in case the website went down. 

\begin{figure}[H]
\centering
\caption{Logging And Monitoring}
\includegraphics[scale=0.52]{imgs/monitor.png}
\end{figure}

Figure 11 shows this application has been up & running for more 50 days and never went down ! 

[^6]: [JWT](https://jwt.io/)
[^7]: [uptimerobot](https://uptimerobot.com/)

\pagebreak