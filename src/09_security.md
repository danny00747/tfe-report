Chapter 6 : Security
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

Figure 7 demonstrates steps that executed to authenticate a user in this application. Obviously there is a lot of things 
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

To limit what a user can do, the latter has to be authenticated through a set of credentials verification process. 
Once successfully authenticated, the user's role is retrieved from the HTTP Authorization header.

Within this application, roles are created for various user types (e.g., admin or user and anonymous). 
The permission to perform certain transactions or access a particular route, a specific role is needed. 
For instance, a user with a role of an `admin` is granted the permission to create, update, read, and 
delete any profile, whereas a user with a role of a `user` is given access to read & update his own profile.

\begin{figure}[H]
\centering
\caption{Spring Security Authorization Process}
\includegraphics[scale=1.3]{imgs/spring-access.png}
\rightline{{\rm --- From Spring Security in Action Book}}
\end{figure}

Step 4 shown in figure 9 might sometimes fail so in the effort to make the application more user-friendly, 
a custom authorization failure handler class was created to deal with users trying to access forbidden routes. 


## Open Web Application Security Project - OWASP

[^6]: [JWT](https://jwt.io/)