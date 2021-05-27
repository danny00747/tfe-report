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


Spring boot was used as the application API to be consumed by the Angular application. 


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
    
    - SGBD : PostgreSQL
    - ORM : Hibernate
    - Migrations : Flyway

### Why Java ?

```{.ts caption="java demo"}
interface Dog {
    bark: () => void;
}

/* The developer has to manually implement
a heuristic check for interface adherence!
When they update the interface, they have
to update the type guards too! */
function isDog(pet: object): pet is Dog {
  return (pet as Dog).bark !== undefined;
}
const dog: any = {bark: () => console.log('woof')};

if (isDog(dog)) {
    // TS now knows that objects within this if statement are always type Dog
    // This is because the type guard isDog narrowed down the type to Dog
    dog.bark();
}
```



## Frontend Architecture

### Technology stack
 
