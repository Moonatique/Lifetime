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
2. <s> Write analyse & argumentation of the subject</s>
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
Anticipate the fact than other applications could feed without passing by the frontend, webservices to create patient and transmission anwser to this need. 

### Domain

The application is mainly a representation of medical data of patient along his life. We can chose and type the data we need to know to apply different process and visualization. At the end we can have roles who can have a different view of a patient.
A piece of this data will be a **transmission**.
Each transmission type correspond to information which can have different access (read, create, update and delete) depending of the role.

I've chosen to use only one structure to handle differente type of transmission : 
- First because that I design for each different type is very similar
- We can add and extend the transmission without changing all process logic

I've chosen 4 types of transmission based on what I know about medical needs

- ***Particularity*** : It represents an health or mental fact which can be a white list of identify particularity (weight, size, sickness, insuline, ...). Here we keep all historic data. So we can have differente transmissions of **size** but with different **date**. We will display the one with the closest date of the current search.
- ***Treatments*** : It represent a medical treatment with medicaments as data and start & end date. We can display all active treatments or search for former treatments wich can inpact current state of the patient.
- ***Event*** : It reprensent an event for the patient which is taking in charge by the medical staff. With at list a start date we can easely know what are events past, current or coming.
- ***Question*** : It reprensent a question from the patient or from the staff with data as anwser. 

For each transmission we allow a statue which is important for *Event* by example. We also allow to restrict transmission to a certain role, in case some information are really senseible even we will see business rules taking care of confidentiality.

I also add a tags field to the transmission in case of search on metadata, by anticipation.

Here the structure of each table : 

**USER**
> - id : id
> - email : string
> - pass : string
> - role : ROLE [patient, doctor, medical, admin]

**PATIENT**
> - id : id
> - user_id : id
> - numSS : string
> - lastname : string
> - firstname : string
> - birthdate : date
> - blood_group : string
> - transmissions : [TRANSMISSION]

**TRANSMISSION**
> - id : id
> - patient_id : id
> - type : TYPE [particularity, treatment, event, question]
> - description : string
> - statue : STATUE [todo, inprogress, done, reported, canceled]
> - start_date : date
> - end_date : date
> - data : [string]
> - from : USER
> - tags : [string]
> - restrictions : [ROLE]

### Business Rules

***! Warning !*** Business rules may need to be review with product owner, they are here as example.

#### Roles

- Patient :       read (ALL - dotors notes) / create (only type "question")         / update (only type "question")         / remove (NONE)
- Doctor :        read (ALL)                / create (ALL)                          / update (ALL)                          / remove (NONE)
- Medical staff : read (ALL - dotors notes) / create (only type "event & question") / update (only type "event & question") / remove (NONE)
- Admin :         read (ALL)                / create (ALL)                          / update (ALL)                          / remove (ALL)

#### Types

- Particularity : If we have same particularity in different transmission then we display the yougest one base on "start_date"
- Treatment     : Display only active treatments with current date between start and end date or without "end_date". We can check statue too.
- Event         : Display last 5 events and coming events

#### Restrictions : 

We can add roles to restriction area to restrict transmission for doctors only by example bypassing role assignation to certain type.
Admin will overrule this because to technical or special search, he needs to access all data.

## Implementation (POC)

### Start application

1. git clone https://github.com/Moonatique/Lifetime.git
2. cd Lifetime
3. mix deps.get
4. mix ecto.migrate
5. mix phx.server
6. open browser localhost:4000

### Use of the application

- You can create some patient and edit them
- You can create new transmission to a patient
- **Warning : Click well on the button save when creating transmission**

### Objectifs

I would like to prof some mechanisme :
- <s>Connect Patient and Transmission</s>
- <s>Handle 2 different types of transmission</s>
- <s>Handle live update of the view</s>
- *(optional) Handle 2 roles (patient and admin)*
- *(optional) Creation of transmission throught web service*


#### Creation of models by generation

*TRANSMISSION*

mix phx.live.html Medical Transmission transmissions type:enum:particularity:treatment:event:question description statue:enum:todo:inprogress:done:reported:canceled start_date:date end_date:date data:array:string patient_id:references:patients

*PATIENT*

mix phx.gen.live Medical Patient patients user_id:references:users numSS lastname firstname birthdate:date blood_group:enum:A+:A-:B+:B-:O+:O-:AB+:AB- transmissions:references:transmissions



