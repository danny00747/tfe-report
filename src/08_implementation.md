Chapter 5 : Implementation
===========================
 
## API

The API of this application is simply a Spring Boot Java application running on an embedded Apache Tomcat Server[^4].
To test different endpoints of this api, **Postman**[^5] was used a testing API tool. 

   - **API Documentation**

An undocumented API is not that useful, there are very many api documentation tools out there but since the api was 
developed in java, a built-in tool in IntelliJ IDEA was used to generate the _**javadoc**_ for the api. 
The latter can be found [here](https://rent-vehicle-api.netlify.app "javadoc").

### MapStruct - Mapping Library

Since an API designed to be consumed by other applications, data integrity and security become crucial when designing 
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

This interface is extends by all interface mappers in the application. Listing 2, shows how I was able 
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
an implementation for it. The `BookingMapperImpl` class implements all `BookingMapper` interface methods which maps 
our `Booking` fields to the `BookingDTO` fields and contrariwise.

### JPA - Java Persistence API

### Mail Service

### Twilio SMS API

### Error Handling 

[^4]: [Tomcat](http://tomcat.apache.org)
[^5]: [Postman](https://www.postman.com/)