Chapter 3 : Software Requirement Specifications - SRS
======================================================

## Overview

This chapter contains the analysis and design of car rental web based application system, the type of
the methodology, function and non-functional requirements of this application and 
software tools that were used during the development phase. In addition, this chapter contains UML diagrams, 
the database design, application architecture to better understand how the application is designed.

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
application stakeholder in order to get some feed-back based on how the final application should look and work from his point 
of view. Secondly because I knew that stakeholder was going to be heavily involved during the application development which 
helped him not only get as soon as possible a glimpse of us how the application works and looks but as well as catch errors 
as they came.

### Approach to Prototyping Methodology

Prototyping methodology has many software development life cycle (**SDLC**) phases, at the first stage,
what I did was gather all non-functional and functional application requirements are gathered from the stakeholder 
by talking him, then moved to the second stage by designing of the application which was presented as a preview of the
application system to the stakeholder in order to identify flaws of the latter. The third stage was about refining the 
prototype according to feedback I was able to gather from the stakeholder. 

## Requirements Analysis

Requirements are the list of functions and features that an application must possess. After several conversations with the
stakeholder, I was able to gather all requirements that were needed to be implemented meet their needs.

My analysis went through many phases such as making a difference between functional and non-functional requirements, setting up 
a data dictionary for database metadata, entity–relationship model to better understand how entities in the system are related 
and finally a relational data model that represents the database's tables. 

### Function Requirements

::: tip

Function requirements describes _What The Application Should Do_.

:::

A full list of function requirements can be found [here.](https://github.com/danny00747/vms/wiki/Function-Requirements "function requirements")

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

A full list of non-functional requirements can be found [here.](https://github.com/danny00747/vms/wiki/Non-Function-Requirements "non-functional requirements")

| Req. No. | Description                                                           | 
|----------|---------------------------------------------------------------------- |
| R-1      | The application' s interface should to be user-friendly & easy to use |
| R-2      | The application should be 24/7 available to customers                 |
| R-3      | Customer's data should be protected from attacks                      | 
| R-4      | The application should maintain data integrity through backups        |     
| R-5      | The website’s load time should not be more than 10 seconds            | 


### Data Dictionary


With width specified:
\begin{center}
\begin{tabular}{ | l | l | l | p{5cm} |}
\hline
Day & Min Temp & Max Temp & Summary \\ \hline
Monday & 11C & 22C & A clear day with lots of sunshine.  
However, the strong breeze will bring down the temperatures. \\ \hline
Tuesday & 9C & 19C & Cloudy with rain, across many northern regions. Clear spells
across most of Scotland and Northern Ireland,
but rain reaching the far northwest. \\ \hline
Wednesday & 10C & 21C & Rain will still linger for the morning.
Conditions will improve by early afternoon and continue
throughout the evening. \\
\hline
\end{tabular}
\end{center}


### Entity–relationship Model

### Relational Data Model


\pagebreak