# Lifetime
Project in answer to an architecture exercice (subject - analyse and argumentation- POC)

## Subject

***En français :*** 
> Les “transmissions” désignent l’ensemble des moyens de communication médicale spécifiquement destinés à transférer les informations portant sur un patient, d’un membre de
> l’équipe soignante vers un autre, ou du patient vers l’équipe patiente.
> 
> Cette opération s’inscrit en général dans l’objectif d’assurer la continuité des soins apportés aux
> patients et est justifiée par la nécessité d’organiser un relais entre les soignants.
> 
> Le but de la transmission est donc d'assurer la continuité des soins et de permettre la prise de décisions ultérieures éclairées. 
> 
> Cet échange, limité dans le temps, doit aboutir à une compréhension commune, entre les différents intervenants.
> Cette compréhension inclut plusieurs dimensions telles que l’histoire du patient et ses
> particularités, les évènements qui se sont déjà produits, ceux qui sont attendus ou susceptibles de se produire. 
> Il convient d’y adjoindre l’organisation des différentes tâches prévues.
>
> Le sujet est tout simple : essayer d’imaginer ce système de communication entre équipes médicales.
> Essayer d’imaginer et d’optimiser toutes les contraintes et logique métier qu’ils pourraient y avoir.
>
> Tu es libre d’utiliser le langage de programmation et les outils que tu souhaites.
> Le but de cet exercice est d’évaluer ta méthodologie de travail, ta façon de concevoir et d’orchestrer tes développements.


## TODO

1. <s> Create Github project</s>
2. Write analyse & argumentation of the subject
3. Implement a POC
4. Tests

## Analyse & argumentation

### Context

As we are around medical aspect we need to think about how to represent a patient and how I share the best informations to the good actor
Through this statement I evaluate different essential functionalies : 
- Harvest data on a patient and gather them in order to have a global view of a patient.
- We have different type of data
- We need to handle historic 
- We need highlight important past events and coming events
- We have different roles in place who can have different use with the data

### Stack

It's not an easy task to do in a short period of time to chose best technologies to awnser to a problem 
but this are some argumentation about the software stack.

#### Language : Elixir

Powerfull language based on the BEAM virtual machine which enable to write fullstack application in a Domain Data Driven approach.
You also have concurrency for free coding and a lot of advance syntax sugar for the joy of developpers
Also elixir have a strong and stable ecosystem.

#### Framework : Phoenix

A powerfull framework to handle MVC for web application. Based on strong mechanism, it comes with all the tooling of elixir and is still extendable.

#### Library : Liveview

Powerfull library to deal with reactive client and view. Based on socket to open connection between server and client.

#### Library : Surface

Domain Specific Language for templating liveview component. Improve joy of frontend developping on phoenix application. It's inspirate by best javascript libraries for components.

### Architecture

I propose a new application which can be feed by data through a web frontend and webservices.
Fullstack application is chosen because I don't know the nature of others application.
Anticipate the fact than other applications could feed without passing by the frontend, a webservice anwser to this need. 

### Domain

The application is mainly a represatation of medical data of patient along his life. We can chose and type the data we need to know to apply different process and visualization. At the end we can have roles who can have a different view of a patient.
A piece of this data will be a **transmission**.

Here the structure of each table : 

**USER**
- id : id
- email : string
- pass : string
- role : ROLE [patient, doctor, medical, admin]

**PATIENT**
- id : id
- numSS : string
- lastname : string
- firstname : string
- birthdate : date
- blood_group : string
- transmissions : [TRANSMISSION]

**TRANSMISSION**
- id : id
- patient_id : id
- type : TYPE [particularity, treatment, event, question]
- description : string
- statue : STATUE [todo, inprogress, done, reported, canceled]
- start_date : date
- end_date : date
- data : [string]
- from : USER
- tags : [string]
- restrictions : [ROLE]

### Business Rules

## Implementation (POC)

I would like to prof some mechanisme :
- Handle 2 different types of transmission
- Handle live update of the view
- *(optional) Handle 2 roles (patient and admin)*
- *(optional) Creation of transmission throught web service*


