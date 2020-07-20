
> Written with [StackEdit](https://stackedit.io/).

# Project Boot Strap

1. An attempt at creating a template Project with ready-to-use classes to handle various comon tasks
2. Project is intented to serve as a repo for all changes and best coding practises I learn
3. Project attempts to divide tasks into independent modules 
4. Provide an interface that can be implmented by any class that wants to provide the functionality
5. The module itself is a stand alone manager class.
6. All modules should be agnostic to Design Patterns
    1. Should be a plug and play version 
    2. Should be easy to integrate with MVC, MVVM, MVP, VIPER
    3. Supply an MVVM ready integrator class
7. Each module should implement an interface that provides the public API
8. Underlying implementations should be swappable
    1. Could Contain multiple classes that implement the public interface that use different 3rd party components that provide the functionality.  
9. Public API should remain same and generic

## Prelims

### Functionalities
1. Network Request Module
2. JSON/XML Parsing
3. Database Interactions Module

## Tasks
| Module | Progress | Status |  
| :------- | ----: | :---: |  
| Network Request  | - [  ] Public API | In Progress |
| JSON/XML Parsing  | - [  ] Public API | In Progress |
| Database Interactions | - [  ] Public API | In Progress |

## Tasks - Overview

### Network Request Module 
- [ ] Design Public Api
- [ ] Add Public Api Interface
- [ ] Design Private Requests API 
- [ ] Add Private Requests API Interface
- [ ] Implement Private Requests API Interface and use URLSession to make Network Requests
- [ ] Design MVVM Wrapper Version of Public API
- [ ] Use Compare Framework 

### JSON/XML Parsing Module 
- [ ] Design Public Api
- [ ] Add Public Api Interface
- [ ] Design Private Parsing API 
- [ ] Add Private Parsing API Interface
- [ ] Implement Private Requests API Interface and use JSONSerialisation to serialise 
- [ ] - [ ] Implement Private Requests API Interface and use XMLParser to serialise
- [ ] Design MVVM Wrapper Version of Public API
- [ ] Use Compare Framework 

### Database Interactions Module 
- [ ] Design Public Api
- [ ] Add Public Api Interface
- [ ] Design Private Requests API 
- [ ] Add Private Requests API Interface
- [ ] Implement Private Requests API Interface and use Coredata as DB 
- [ ] Implement Private Requests API Interface and use SQLite as DB
- [ ] Design MVVM Wrapper Version of Public API
- [ ] Use Compare Framework 

## Tasks - Details
Network Request Module 
- Request/Ask 
- [ ] Design Public Api for a class that provides http/file Request parameters
    - [ ] Use URLRequests to represent http/file requests
        - [ ] Create a generic builder class to build UrlRequest object - **UrlRequestBuilder**
        - [ ] So that a new class can also be used instead of UrlRequest without changing the builders public API
    - [ ] Create a  protocol that takes in the UrlRequestBuilder class
    - [ ] Define an interface that uses

- Response/ Reply   
- [ ] Design Public Api for a class that provides http/file Request Response
- [ ] Provide a public interface that Model Classes can conform to 
- [ ] Provide response as Dictionary by default
    - [ ] Use URLRequests to represent http/file requests
        - [ ] Create a generic builder class to build UrlRequest object - **UrlRequestBuilder**
        - [ ] So that a new class can also be used instead of UrlRequest without changing the builders public API
    - [ ] Create a  protocol that takes in the UrlRequestBuilder class
    - [ ] Define an interface that uses

