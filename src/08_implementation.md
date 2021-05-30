Chapter 5 : Implementation
===========================
 
## API

The API of this application is simply a Spring Boot Java application running on an embedded Apache Tomcat Server[^4].
To test different endpoints of this API, **Postman**[^5] was used a testing API tool. 

   - **API Documentation**

There are very many api documentation tools out there but since the api was 
developed in java, a built-in tool in IntelliJ IDEA was used to generate the _**javadoc**_ for the API. 
The latter can be found [here](https://rent-vehicle-api.netlify.app "javadoc").

### MapStruct - Mapping Library

Since an API is designed to be consumed by other applications, data integrity and security become crucial when designing 
an API. Most of the time, an external API or the end-user doesn't need to access the entirety of the data from a 
database model, but only some specific fields. In such scenarios Data Transfer Objects (**DTOs**) come in handy. 


```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

In the field of programming a data transfer object (**DTO**) is an object that carries data between processes.
The motivation for its use is that communication between processes is usually done resorting to remote interfaces
(e.g., web services), where each call is an expensive operation.  \newline

Because the majority of the cost of each call is related to the round-trip time between the client and the server, 
one way of reducing the number of calls is to use an object (the DTO) that aggregates the data that would have been 
transferred by the several calls, but that is served by one call only.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

Since DTOs are a just reflection of objects stored in the database - mappers between DTO classes & model classes 
play a major role in the conversion process. For this application **MapStruct** was used a mapping library to map a DTO 
from its entity and contrariwise. It tremendously reduces the amount of boilerplate code which would have had to be 
written by hand but since it uses annotation-processing to generate mapper class implementations at compile time, 
all I had to write were interfaces.

  - **MapStruct Example**

The first thing that was implemented for mappers was the Entity Mapper interface for a generic dto to entity.

```{.java caption="EntityMapper"}
/**
 * @param <D> - DTO type parameter.
 * @param <E> - Entity type parameter.
*/

public interface EntityMapper<D, E> {

    E toEntity(D dto);

    D toDto(E entity);

    Collection<E> toEntity(Collection<D> dtoList);

    Collection<D> toDto(Collection<E> entityList);

    @Named("partialUpdate")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(@MappingTarget E entity, D dto);
}
```

This interface is extends by all interface mappers in the application. Listing 4, shows how I was able 
to map a dto to it's model class. 

Let's say we have to map a `Booking` class to it's `BookingDTO` class. 

```{.java caption="Booking"}

@Entity
public @Data class Booking extends AbstractAuditingEntity {

    @Id
    private UUID id;
    private Instant cancellationDate;
    
    @Enumerated(EnumType.STRING)
    private BOOKINGSTATE bookingState;
    
    private Instant withdrawalDate;
    private Instant returnDate;
}

```

```{.java caption="BookingDTO"}

public @Data class BookingDTO {

    private String bookingId;

    private Instant cancellationDate;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private BOOKINGSTATE bookingState;

    private Instant withdrawalDate;

    private Instant returnDate;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Instant createdAt;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private CarDTO carDTO;

}
```

Now, to make a mapper between these two classes, a `BookingMapper` interface was created. By annotating it with `@Mapper`, 
MapStruct concludes that this is a mapper between our two classes:

```{.java caption="BookingMapper"}

@Mapper(componentModel = "spring", uses = {CarMapper.class})
interface BookingMapper extends EntityMapper<BookingDTO, Booking> {

    BookingDTO toDto(Booking booking);

    @Mapping(target = "id", ignore = true),
    Booking toEntity(BookingDTO bookingDTO);
    
    void partialUpdate(@MappingTarget User user, UserInfoDTO userInfoDTO);

}
```

At compile time, the MapStruct annotation processor plugin will pick up the `BookingMapper` interface and generate 
an implementation for it. The `BookingMapperImpl` class implements all `BookingMapper` interface methods which one of 
them (`toDto`) maps the `Booking` class fields to the `BookingDTO` class fields.

### Mail Service

To send mails to customers upon a successful booking confirmation, **SendGrid API** was used as an 
Email Delivery Service.

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

**SendGrid** (also known as Twilio SendGrid) is a Denver, Colorado-based customer communication platform for transactional 
and marketing email. It provides a cloud-based service that assists businesses with email delivery. The service 
manages various types of email including shipping notifications, friend requests, sign-up confirmations, and 
email newsletters. 

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

```{.java caption="MailService"}

@Profile("prod")
@Service
public class MailService {

    private final String sendGridAPIKey;

    public MailService(SendGridConfiguration sendGridConfiguration) {
        this.sendGridAPIKey = sendGridConfiguration.getApiKey();
    }

    public void sendEmailConfirmation(String emailTo) {
    
        var from = new Email("he201718@students.ephec.be");
        var subject = "Confirm Your Email !";
        var to = new Email(emailTo);
        var content = new Content("text/html", emailTemplate());
        var mail = new Mail(from, subject, to, content);
        var request = new Request();
        
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            SendGrid sg = new SendGrid(sendGridAPIKey);
            Response response = sg.api(request); // 202 if ok
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
```

### Twilio SMS API

To send SMS to customers to remind them for instance when to pick up their rented car or to confirm their phone number,
**Twilio API** was used as an SMS Delivery Service.

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

**Twilio** is an American cloud communications platform as a service (CPaaS) company based in San Francisco, 
California. It allows software developers to programmatically make and receive phone calls, send and receive text 
messages, and perform other communication functions using its web service APIs.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

### Error Handling 

Handling exceptions is a crucial part when developing a robust application. Spring Boot offers more 
than one way of doing it. Since it's version 3.2, there is the `@ControllerAdvice` annotation to unify exception 
handling across the whole application.

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=Why is it called "Controller Advice" ?,coltitle=white,
fonttitle=\bfseries]

The term 'Advice' comes from Aspect-Oriented Programming (AOP) which allows us to inject cross-cutting 
code (called "advice") around existing methods. A controller advice allows us to intercept and modify 
the return values of controller methods, in our case to handle exceptions.  \newline

\rightline{{\rm --- From reflectoring.io}}

\end{tcolorbox}



```{.java caption="ControllerAdvice"}

@ControllerAdvice
public class GlobalExceptionHandler {

   /**
     * A method to handle email duplication across the whole application.
     */
    @ExceptionHandler({EmailAlreadyUsedException.class})
    public ResponseEntity<Map<String, String>> emailAlreadyUsedException(EmailAlreadyUsedException ex) {
        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(Map.of("message", ex.getMessage()));
    }
}

```

## Database

### Overview

This application uses **PostgreSQL** was its database. The latter was chosen firstly because it's an open source
database secondly a relational database was a needed to handle all interrelations between entities and lastly 
because it's a feature-rich database that supports things like Full-text Search and JSON for instance.

### Database Migrations - Flyway

Ideally its good to have well-thought-out schema of a database at the beginning of a project but with 
evolving requirements changes to the initial schema tend to happen quite often. A database schema literally represents 
the application so changes to the latter must be carefully executed to avoid losing the currently stored data. 
To tackle this problem **Flyway** was used a database-migration tool.

```{=latex}
\begin{awesomeblock}[black]{0.4pt}{\faWikipediaW}{black} 
```

In software engineering, schema migration (also database migration, database change management) refers to the 
management of incremental, reversible changes and version control to relational database schemas. A schema migration 
is performed on a database whenever it is necessary to update or revert that database's schema to some newer or older 
version.

\rightline{{\rm --- Wikipedia}}

```{=latex}
\end{awesomeblock}
```

Flyway migrations can be written in SQL or Java but SQL base migrations were chosen for simplicity. 

```{.sql caption="Booking Table"}

CREATE TABLE booking
(
    id                uuid            DEFAULT        PRIMARY KEY,
    cancellation_date TIMESTAMPTZ,
    booking_state     d_booking_state DEFAULT 'OPEN' NOT NULL,
    withdrawal_date   TIMESTAMPTZ                    NOT NULL,
    return_date       TIMESTAMPTZ                    NOT NULL,
    user_id           uuid                           NOT NULL UNIQUE,
    car_id            uuid,
    CHECK (return_date > withdrawal_date),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (car_id) REFERENCES cars (id) 
);

```

[^4]: [Tomcat](http://tomcat.apache.org)
[^5]: [Postman](https://www.postman.com/)

\pagebreak