Chapter 4 : Software Design
============================

## System Architecture

The application was developed using the following architecture:

\begin{figure}[H]
\centering
\caption{System Architecture}
\includegraphics[scale=0.7]{imgs/system-archi.png}
\end{figure}

\rightline{{\rm --- From frontbackend.com}}


The system is made of three components : 

   - The backend Spring Boot application as an API to be consumed by the Angular application. 
   - The frontend Angular application as the client side of this whole system.
   - The PostgreSQL database used by the API.


## Backend Architecture

\begin{figure}[H]
\centering
\caption{Spring Boot Architecture}
\includegraphics[scale=0.6]{imgs/spring-archi.png}
\end{figure}

\rightline{{\rm --- From petrikainulainen.net}}


### Technology stack

- Language : JAVA 15
- Web Framework: Spring Boot
- Build Tool : Maven

    **Database :** 
    
    - DBMS : PostgreSQL
    - ORM : Hibernate
    - Migrations : Flyway

### Why Java ?

  - Java Ergonomics 

The craftsmanship of JetBrains makes Java really easy to use. Most java features are autocompleted, jump to java 
doc is really fast, method and class refactoring is done efficiently. However, I gravitated towards Java because 
I wanted a good and efficient developer experience with third-party libraries. When consuming third-party 
libraries in Java, you always know exactly what types are needed for a method but most importantly, an incorrect 
usage of the latter will result into a compilation error. 

  - Nominal Typing

On of the reasons a dynamic typed language wasn't chosen is because I wanted my application to fail at build
time rather than at runtime upon a change in a third-party method. It's completely a waste of time when you have
to refer back to the implementation of a method to figure out which type(s) to pass it.

The typed version of Javascript called TypeScript somehow solves this problem, but still lack the ability to validate 
passed types at runtime without extra code. You have to implement yourself typing/interfaces for you to have some 
type safety in your application.


## Frontend Architecture

The Angular application was developed using the following architecture:

\begin{figure}[H]
\centering
\caption{Angular Architecture}
\includegraphics[scale=0.24]{imgs/angular-archi.jpeg}
\end{figure}

\rightline{{\rm --- From tomastrajan.medium.com}}


### Technology stack

- Language : TypeScript
- Framework: Angular 10
- Build Tool : NPM
- CSS Library: PrimeNG
