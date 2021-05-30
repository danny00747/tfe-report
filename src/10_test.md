Chapter 7 : Application Testing
================================

A full Tests report can be found [here](https://rent-vehicle-test-report.netlify.app/index.html "tests report").

## Unit Test

Unit testing an applications has many benefits such as ensuring every component of the latter works as it should, 
facilitating code refactoring & design improvement and more importantly reduces bug fixing cost. 

**JUnit** was used as a unit testing tool in this application. 

```{.java caption="Assert username can be found"}

 @Test
 @DisplayName("assert that user can be found by username")
 public void assertThatUserCanBeFoundByUsername() {
   var userDetails = domainUserDetailsService.loadUserByUsername(USER_ONE_LOGIN);
   assertThat(userDetails).isNotNull();
   assertThat(userDetails.getUsername()).isEqualTo(USER_ONE_LOGIN);
}

```

## Integration Test


```{.java caption="Should get one car by its id"}

 @Test
 @Transactional
 @DisplayName("should get one car by its id")
 public void getCar() throws Exception {
    
   // Initialize the database
   var savedCar = carDAO.saveAndFlush(car);
   
   restCarMockMvc
    .perform(get("/api/v1/cars/{id}", savedCar.getId()))
    .andExpect(status().isOk())
    .andExpect(jsonPath("$.isDamaged").value(DEFAULT_IS_DAMAGED))
    .andExpect(jsonPath("$.licensePlate").value(DEFAULT_LICENSE_PLATE))
}

```

\pagebreak

Integration testing plays a major role in the application development cycle by making sure the backend endpoints
work as expected. To achieve the latter, **MockMvc**[^8] was used to test the web layer and perform requests against
a mocked servlet environment. There were no real HTTP request going around during the integration tests since 
the latter are executed in a mocked environment provided by Spring.

## Architecture Testing - ArchUnit[^9]

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=What is ArchUnit ?,coltitle=white, fonttitle=\bfseries]

\textbf{ArchUnit} is a free, simple and extensible library for checking the architecture of your Java code. That is, 
ArchUnit can check dependencies between packages and classes, layers and slices, check for cyclic dependencies and 
more. It does so by analyzing given Java bytecode, importing all classes into a Java code structure. ArchUnit’s 
main focus is to automatically test architecture and coding rules, using any plain Java unit testing framework.

\rightline{{\rm --- From archunit.org}}

\end{tcolorbox}

### ArchUnit To The Rescue

A common problem that occurs quite often in a Software Development Life Cycle is that code implementation can often 
diverge from the initial design and architecture. This is where ArchUnit comes into play to test that a code 
implementation is consistent with the initially defined design.

One of the main reason of software architecture, when it comes to codebase, is maintainability, and to keep an
application maintainable, testable, and extendable, an effort to make sure it is modular, interdependencies 
are as small as possible and there no loose coupling between components needs to be made.

Furthermore, in an evolving application, implementation rules evolve over time. The use of ArchUnit tests 
forces us developers to purposely accept deviations from predefined rules instead of haphazardly encountering 
them later in a test feature or actually never. ArchUnit issues warnings about deviations.

ArchUnit allowed me to test the following : 

- Package dependency 
- Class dependency 
- Naming conventions
- Layered packages constraints


```{.java caption="Layer Dependencies"}

 @Test
 @DisplayName("layer dependencies should be respected")
 public void layer_dependencies_are_respected() {

   layeredArchitecture()
     .layer("Controllers").definedBy("be.rentvehicle.web..")
     .layer("Services").definedBy("be.rentvehicle.service..")
     .layer("Persistence").definedBy("be.rentvehicle.dao..")

     .whereLayer("Controllers").mayNotBeAccessedByAnyLayer()
     .whereLayer("Services").mayOnlyBeAccessedByLayers("Controllers")
     .whereLayer("Persistence").mayOnlyBeAccessedByLayers("Services")
     .ignoreDependency(DomainUserDetailsService.class, UserDAO.class)
     .check(importedClasses);
}
```

## End-to-End Test - Puppeteer[^10]

E2E tests live demo [here](https://github.com/danny00747/vms/wiki/Test-Reports "e2e report").

An end-to-end tests are all about testing an application from the end customer’s perspective and making sure business 
requirements are met. To achieve this feat, a Node library called Puppeteer was used. 

### Puppeteer

**Puppeteer** is a browser automation Node library from the Google Chrome team which enables developers to control 
Chrome/Chromium and execute common actions, much like in a real browser - programmatically, through a decent API.
Simply put, it’s a super useful and easy tool for automating, testing and scraping web pages. It runs headlessly by 
default, but can be configured to run in headful mode which helps while debugging.

It's important to note that puppeteer \underline{is not} a testing tool. It doesn't come with built-in testing assertions, 
it's just a tool for controlling the browser. But if it's used along with real testing tools such as Mocha & Chai,
we get a fascinating framework that can test the application as if it was being used by a customer. 
In other words the combination of Puppeteer, Mocha & Chai helps us test our app from the user's perspective. \newline \newline


```{.js caption="E2E Test Example"}

describe('/POST Login', async () => { 
    
   it('it should login a user', async () => {

       const pseudo = await page.$('#pseudo'); //
       const password = await page.$('#password');
       const submit = await page.$('#submitBtn');

       await pseudo.click({ clickCount: 3 });
       await pseudo.type('john@gmail.com');

       await password.click({ clickCount: 3});
       await password.type('az#azx=3*ùâzH2é01');

       await submit.click();
       await page.waitForNavigation();

       expect(page.url()).eql('http://localhost:4200/gallery');

       const logoutBtn = await page.$('#logoutBtn');
       await logoutBtn.click();
       await page.waitForNavigation();

       expect(page.url()).eql('http://localhost:4200/login');

   });
}); 


```

[^8]: [MockMvc](https://spring.io/guides/gs/testing-web)
[^9]: [ArchUnit](https://www.archunit.org)
[^10]: [Puppeteer](https://pptr.dev)

\pagebreak
