Chapter 2 : Literature Review
==============================

## Overview

This chapter contains a literature review for the application that was developed. The review describes the existing 
systems that are similar to the car rental management system. References are made to source from the internet.

Furthermore, literature review helps to provide an overview on how the **TOPSIS**[^1] technique was used as a method 
in multiple criteria decision-making to prioritize the best car possible for users of the applications.

## Multi-Criteria Decision Making Method

As the name implies, Multi-Criteria Decision-Making also known as MCDM is about methods for making decisions 
when multiple criteria need to be considered together, in order to rank or choose/prioritize between the alternatives 
being evaluated.

### Technique for Order of Preference by Similarity to Ideal Solution - TOPSIS


```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

The **TOPSIS** is a multi-criteria decision analysis method developed by Hwang and
Yoon (1981) with further developments by Yoon (1987) and Hwang, Lai and Liu (1993)
(Surendra, 2016).

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

After some research about how to provide the best ideal car possible to client, TOPSIS is the best algorithm 
for this application because it will make the latter more efficient.


The TOPSIS algorithm is to contrive the best ideal solution (note as s+), and the
worst ideal solution (note as s-) to the problem of multiple criteria while the s+ is hypnotically
optimal solution from the criteria, but the s- is the worst solution from the criteria. The rule is to rank and compare 
each alternative of the result with s+ and s-.  \newline

The TOPSIS algorithm was carried out as follows:

#### Step 1 : Construct the decision matrix and determine the weight of criteria. \newline \newline

Let's say we have three cars available for rent with three criteria as Table 1

| Attribute/Criteria  | Price  | Numbers of Passengers | Number of Bags | Class    |
|---------------------|--------|-----------------------|----------------|----------|
| Volkswagen Polo     |  110€  | 3                     | 2              | Basic    |  
| Toyota Yards        |  230€  | 5                     | 4              | Standard |  
| Opel Zafira         |  300€  | 9                     | 7              | Premium  | 


Table:  Table of Criteria.

Table 1 shows that each car have their criteria. If we convert the class linguistic terms using the 5 point scale,
we get the following table : 

| Attribute/Criteria  | Price  | Numbers of Passengers | Number of Bags | Class    |
|---------------------|--------|-----------------------|----------------|----------|
| Volkswagen Polo     |  110€  | 3                     | 2              | 2        |  
| Toyota Yards        |  230€  | 5                     | 4              | 3        |  
| Opel Zafira         |  300€  | 9                     | 7              | 5        | 


Table:  Table of Criteria with 5 point scale.



#### Step 2 :  Calculate the normalized decision matrix. \newline \newline

This is the formula for vector normalization : 

\begin{equation}
\ \scalebox{1.5}{$\displaystyle n_{ij} = \frac{ x_{ij}}{ \sqrt{\sum_{i=1}^{m} x^2_{ij}}}$} \
\end{equation}

Let's start by calculating the denominator for the price column :

\begin{equation} \label{eq1}
\begin{split}
\sqrt{\sum_{i=1}^{m} x^2_{ij}} & = 110^2 + 230^2 + 300^2 = 155000 \\
& = \sqrt{155000} = 393.70 
\end{split}
\end{equation}

| Attribute/Criteria  | Price   | Numbers of Passengers | Number of Bags | Class    |
|---------------------|---------|-----------------------|----------------|----------|
| Volkswagen Polo     |  110€   | 3                     | 2              | 2        |  
| Toyota Yards        |  230€   | 5                     | 4              | 3        |  
| Opel Zafira         |  300€   | 9                     | 7              | 5        | 
| Performance Value   |  393.70 | 10.72                 | 8.30           | 6.16     | 

Table:  Table of Criteria with the performance value

Next, the data for each criterion will be normalised. Divide the data with their own
criteria performance values as shown in Table 3 to get result.


| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags | Class                   |
|---------------------|------------------------------|-----------------------|----------------|-------------------------|
| Volkswagen Polo     | $\frac{110}{393.70}$ = 0.27  | 0.27                  | 0.24           | $\frac{2}{6.16}$ = 0.32 |  
| Toyota Yards        |  0.58                        | 0.46                  | 0.48           | 0.48                    |  
| Opel Zafira         |  0.76                        | 0.83                  | 0.84           | 0.81                    |

Table:  Table of Criteria with the normalised values

The value in each sell is known as the normalized performance value. 

#### Step 3 :  Calculate the weighted normalized decision matrix \newline \newline

The weighted normalized value $v_{ij}$ v is calculated in the following way:

$v_{ij}$ = $w_j$ $n_{ij}$ for i = 1, ..., m; j = 1, ..., n where $w_j$ is the weight of j-th criterion, $\displaystyle\sum_{j=1}^{n} w_j = 1$

This means that each criterion should have its own weight so that all of them will sum up to 1.

Let weight price be = 0.4, number of passengers = 0.2, number of bags = 0.1 and class = 0.3. 
The normalised value will be multiplied by corresponding normalised weight. as shown in Table 5.

| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags    | Class              |
|---------------------|------------------------------|-----------------------|-------------------|--------------------|
| Volkswagen Polo     | 0.27 * 0.4 = 1.10            | 0.05                  | 0.02              | 0.32 * 0.3 = 0.09  |
| Toyota Yards        | 0.23                         | 0.09                  | 0.04              | 1.44               |  
| Opel Zafira         | 0.30                         | 0.16                  | 0.08              | 0.24               |

Table:  Table of Criteria with the weighted normalised values


#### Step 4 :  Determine the worst alternative and the best alternative \newline \newline

| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags      | Class              |
|---------------------|------------------------------|-----------------------|---------------------|--------------------|
| Volkswagen Polo     | 1.10                         | 0.05                  | 0.02                | 0.09               |
| Toyota Yards        | 0.23                         | 0.09                  | 0.04                | 1.44               |  
| Opel Zafira         | 0.30                         | 0.16                  | 0.08                | 0.24               |
| $V^+$               | \color{blue} 0.23            | \color{blue} 0.16     | \color{blue} 0.08   | \color{blue} 0.09  |   
| $V^-$               | \color{red} 1.10             | \color{red} 0.05      | \color{red} 0.02    | \color{red} 1.44   |

Table:  Table of Criteria with positive ideal and negative ideal solutions.

From table 6 $V^+$ represents the best ideal solution while $V^-$ is the worst ideal solution. $V^+$
is taken from the highest value while $V^-$ taken from the lowest value. For the price column a lower value is desired hence V+ 
indicates the lowest value same goes for the class column as these two are linked. 

#### Step 5 :  Find the Euclidean distance between the best ideal solution(V+), and the worst(V-). 

- _The Euclidean formula from the ideal best value_

\begin{equation}
\ \scalebox{1.5}{$\displaystyle s_{i}^+ = { \sqrt{\sum_{i=1}^{m} (v_{ij} -  v_{j}^+)^2 }}$} \
\end{equation}

\begin{equation} 
\begin{split}
\sqrt{\sum_{i=1}^{m} (v_{ij} -  v_{j}^+)^2 } & = (1.10 - 0.23)^2 + (0.05 - 0.16)^2 + (0.02 - 0.08)^2 + (0.09 - 0.09)^2  = 0.765 \\
& = \sqrt{0.7656} = 0.87
\end{split}
\end{equation}

- _The Euclidean formula from the ideal worst value_

\begin{equation}
\ \scalebox{1.5}{$\displaystyle s_{i}^- = { \sqrt{\sum_{i=1}^{m} (v_{ij} -  v_{j}^-)^2 }}$} \
\end{equation}

\begin{equation}
\begin{split}
\sqrt{\sum_{i=1}^{m} (v_{ij} -  v_{j}^+)^2 } & = (1.10 - 1.10)^2 + (0.05 - 0.05)^2 + (0.02 - 0.02)^2 + (0.09 - 1.44)^2  = 1.82 \\
& = \sqrt{1.82} = 1.35
\end{split}
\end{equation}


| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags      | Class              |  $S^+$ | $S^-$ |
|---------------------|------------------------------|-----------------------|---------------------|--------------------|--------|-------|
| Volkswagen Polo     | 1.10                         | 0.05                  | 0.02                | 0.09               | 0.87   | 1.35  | 
| Toyota Yards        | 0.23                         | 0.09                  | 0.04                | 1.44               | 1.35   | 0.86  | 
| Opel Zafira         | 0.30                         | 0.16                  | 0.08                | 0.24               | 0.30   | 1.45  | 
| $V^+$               | \color{blue} 0.23            | \color{blue} 0.16     | \color{blue} 0.08   | \color{blue} 0.09  |        |       | 
| $V^-$               | \color{red} 1.10             | \color{red} 0.05      | \color{red} 0.02    | \color{red} 1.44   |        |       | 

Table:  Table of Criteria with the euclidean distance

#### Step 6 :  Calculate the relative closeness to the positive ideal solution \newline \newline

The formula to calculate the performance score is as follows : 

\begin{equation}
\ \scalebox{1.5}{$\displaystyle p_{i} = \frac{s_{i}^-}{(s_{i}^- + s_{i}^-)} $} \
\end{equation}


| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags      | Class              | $p_i$  | 
|---------------------|------------------------------|-----------------------|---------------------|--------------------|--------|
| Volkswagen Polo     | 1.10                         | 0.05                  | 0.02                | 0.09               | 0.6   | 
| Toyota Yards        | 0.23                         | 0.09                  | 0.04                | 1.44               | 0.3   | 
| Opel Zafira         | 0.30                         | 0.16                  | 0.08                | 0.24               | 0.8   |

Table:  Table of Criteria with the performance score

#### Step 7 :  Rank the performance score in descending order or select the alternative closest to 1 \newline \newline


| Attribute/Criteria  | Price                        | Numbers of Passengers | Number of Bags      | Class              | Rank   | 
|---------------------|------------------------------|-----------------------|---------------------|--------------------|--------|
| Volkswagen Polo     | 1.10                         | 0.05                  | 0.02                | 0.09               | 2      | 
| Toyota Yards        | 0.23                         | 0.09                  | 0.04                | 1.44               | 3      | 
| Opel Zafira         | 0.30                         | 0.16                  | 0.08                | 0.24               | 1      |

Table:  Table of Criteria with ranked performance score

After all these steps its safe to say that Opel Zafira is the most ideal solution for given criteria.
The application will display cars based on their ranks meaning Opel Zafira will be at the top, followed by Volkswagen Polo and lastly Toyota Yards. 
This is how I was able to provide to the client the best car possible given some criteria.

## Related Work

**A.** **Avis**

Avis[^2] is Belgium a company based in Brussels. 

This platform is used to ensure the customers have access car hire services. There are several characteristics
for this application. User can find car and pick-up point based on a customer selected location.
Customer can easily choose a car, book it after a successful online payement. The customer can select which location 
to drop off the car upon return date.  \newline

**B.** **Europcar**

**Europcar**[^3] a global leader in car rental business. 

This application is dedicated to making car hire online as easy as possible and providing online services worldwide.

This application provides many services such as negotiated rate that are numeric-only discount codes for companies that have a partnership with Europcar.



[^1]: [TOPSIS](https://en.wikipedia.org/wiki/TOPSIS)
[^2]: [Avis](https://www.avis.be)
[^3]: [Europcar](https://www.europcar.com)

\pagebreak