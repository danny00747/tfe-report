Chapter 9 : DevOps
===================

## Web Hosting Service - Heroku

\begin{tcolorbox}[colback=green!5,colframe=green!35!black,
title=What is Heroku ?,coltitle=white, fonttitle=\bfseries]

\textbf{Heroku} is a platform as a service based on a managed container system, with integrated data services and a powerful 
ecosystem, for deploying and running modern apps. The Heroku developer experience is an app-centric approach for 
software delivery, integrated with today’s most popular developer tools and workflows.

\rightline{{\rm --- From heroku.com}}

\end{tcolorbox}

## Deployment Process 

The Spring Boot application was locally built & packaged and then deployed a jar to Heroku. This is achieved using 
Heroku CLI Deploy Plugin[^11] which deploys a jar or war file to Heroku.

Here are the steps that were followed to deploy the packaged jar on Heroku : 

   1. Install Heroku Deploy CLI Plugin

        >`heroku plugins:install heroku-cli-deploy`
        >

   2. Package Spring Boot application

        >`mvn clean package`
        >

   3. Deploy the jar file on Heroku

        >`heroku deploy:jar vms.jar --app rent-vehicle`
        >

   4. Port binding
      
      Heroku requires an application to listen on the port passed through `$PORT` environment variable. 
      A Procfile[^12] file was used to customize the command that is used to run the application. 
      The customized command includes the server.port configuration that is used by Spring Boot to bind the app.
      
        >`web: java $JAVA_OPTS -jar vms.jar -Dserver.port=$PORT $JAR_OPTS`
        >

[^11]: [Heroku CLI Deploy Plugin](https://github.com/heroku/heroku-cli-deploy)
[^12]: [Procfile](https://devcenter.heroku.com/articles/procfile)

\pagebreak
