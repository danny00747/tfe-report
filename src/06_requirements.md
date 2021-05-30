Chapter 3 : Software Requirement Specifications - SRS
======================================================

## Overview

This chapter contains the analysis and design of this application, the chosen type of
the methodology, function & non-functional requirements and software tools that were used during the development phase. 
In addition, this chapter contains UML diagrams, the database design, the application architecture to better understand 
how the application is designed.

## Proposed Methodology

Methodology in software development is the process of dividing the latter into distinct phases to improve design, 
product quality etc... Each of methodology is chosen based on the nature of the application to be implemented and on what 
the stakeholders of the system required. For this particular application **Prototyping model** was chosen.

### Prototyping Model 

\begin{figure}[H]
\centering
\caption{Prototyping Model}
\includegraphics[scale=0.4]{imgs/prototyping-model.jpeg}
\end{figure}

\rightline{{\rm --- From codebots.com}}

**Prototyping model** was chosen firstly because it allowed me to implement many prototypes which were presented to the 
stakeholder in order to get some feed-back based on how the final application should look and work from his point 
of view. Secondly because I knew that stakeholder was going to be heavily involved in the creation of this application which 
by the way helped him not only get as soon as possible a glimpse of how the application works and looks but as well as 
point out unwanted features as they came.

### Approach to Prototyping Methodology

Prototyping methodology has many software development life cycle (**SDLC**) phases, at the first stage, 
all non-functional and functional application requirements are gathered from the stakeholder through multiple conversations, 
then the second stage was about presenting the designed prototype in order to identify its flaws from his perspective. 
The third stage was about refining the prototype according to the gathered feedback. 

## Requirements Analysis

Requirements are the list of functions and features that an application must possess. After several conversations 
with the stakeholder, Over time all requirements that were needed to be implemented meet his needs were gathered.

My analysis went through many phases such as making a difference between functional and non-functional requirements, 
setting up a data dictionary for the database metadata, entity–relationship model to better understand the interrelations 
between the system entities finally a relational data model that literally represents the database's tables. 

### Function Requirements

::: tip

Function requirements describes _What The Application Should Do_.

:::

A full list detailed of function requirements can be found [here](https://github.com/danny00747/vms/wiki/Function-Requirements "function requirements").

| Req. No. | Description                                                               |
|----------|---------------------------------------------------------------------------|
| R-1      | A customer should be able to register with email account                  |
| R-2      | A customer should be able to view the details of any particular car       |
| R-3      | The application should display available cars to the customer             | 
| R-4      | A customer should be able to cancel a reservation                         | 
| R-5      | A customer should be able to book a car through the application           | 

Table: Function Requirements

### Non-functional Requirements

::: tip

Non-functional requirements describes _How The Application Should Behave_.

:::

A full detailed list of non-functional requirements can be found [here](https://github.com/danny00747/vms/wiki/Non-Function-Requirements "non-functional requirements").

| Req. No. | Description                                                       | 
|----------|-------------------------------------------------------------------|
| R-1      | The application's interface should be user-friendly & easy to use |
| R-2      | The application should be 24/7 available to customers             |
| R-3      | Customer's data should be protected from attacks                  | 
| R-4      | The application should maintain data integrity through backups    |     
| R-5      | The website’s load time should not be more than 10 seconds        | 

Table: Non-functional Requirements

### Data Dictionary

In a Database Management System (**DBMS**), a data dictionary contains database metadata, in other words characteristics 
of the stored data and relationships between entities.

The full data dictionary can be found [here](https://github.com/danny00747/vms/wiki/Non-Function-Requirements "non-functional requirements").


| Attribute      | Description                       | Type    | Constraints       |
|----------------|-----------------------------------|---------|-------------------|
| name           | The client's name                 | VARCHAR | Required          |
| bookingId      | An id of a reservation            | UUID    | Required & Unique |  
| cancelledDate  | A reservation's cancelled date    | Date    | Not required      | 
| brand          | The car's model brand             | VARCHAR | Required & Unique | 
| costPerDay     | The cost of a rented car per day  | INTEGER | Required          | 

Table: Data Dictionary

### Entity–relationship Model

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

In software engineering, an **Entity–relationship** model is commonly formed to represent things a business needs to remember 
in order to perform business processes. Consequently, the ER model becomes an abstract data model, that defines a data or 
information structure which can be implemented in a database, typically a relational database.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

\begin{figure}[H]
\centering
\caption{Entity–relationship Diagram}
\includegraphics[scale=0.49]{imgs/tfe-er.png}
\end{figure}


### Relational Data Model


```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

The purpose of the **relational model** is to provide a declarative method for specifying data and queries: users directly state 
what information the database contains and what information they want from it, and let the database management system software 
take care of describing data structures for storing the data and retrieval procedures for answering queries.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

\begin{figure}[H]
\centering
\caption{Relational Diagram}
\includegraphics[scale=0.49]{imgs/tfe-rel.png}
\end{figure}

### Business Rules

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

A **business rule** defines or constrains some aspect of business and always resolves to either true or false. 
Business rules are intended to assert business structure or to control or influence the behavior of the business.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

A full detailed list of business rules can be found [here](https://github.com/danny00747/vms/wiki/Non-Function-Requirements "non-functional requirements").

| BR. No. | Description                                         | 
|---------|-----------------------------------------------------|
| BR-1    | Only registered customers can book cars             |
| BR-2    | Every car in the system must have model             |
| BR-3    | A client must have a driving licence to rent a car  | 
| BR-4    | A customer can only book one car at once            |     
| BR-5    | Every rent must be linked to its reservation        | 

Table: Business Rules

\pagebreak