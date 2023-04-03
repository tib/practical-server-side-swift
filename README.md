# 📖 Practical Server Side Swift

Vapor 4 code samples for the [Practical Server Side Swift book](https://gumroad.com/l/practical-server-side-swift) available on [Gumroad](https://gumroad.com/l/practical-server-side-swift).  

**Chapter 1: Introduction** We start with an introduction to the Server Side Swift world, explaining the evolution of Swift as a universal programming language. We'll talk about both the strengths and weaknesses of the language and discuss why Swift is a good choice to build backend applications. We'll explore the Swift ecosystem and the open-source movement that made it possible to create the necessary tools on Linux to turn Swift into a server-side language. You'll get introduced to Vapor, the most popular web application framework, that we're going to use in this book.

**Chapter 2: Getting started with Vapor** Next, we go over detailed instructions about how to install all the required components to build server-side Swift applications both on Linux and macOS. You'll meet some command-line tools that can help your everyday life as a backend developer and we'll create our very first Vapor project using the Swift Package Manager. We'll also set up the Vapor toolbox, a handy little tool that can help you bootstrap projects based on a template. In the very last section, we'll briefly take a look at the architecture of a Vapor application.

**Chapter 3: Getting started with SwiftHtml** Then we're going to build our first website using the SwiftHtml library, and we're going to generate HTML code through Swift by creating template files using a Domain Specific Language (DSL). You'll learn about how to connect SwiftHtml with Vapor and how to render HTML by using context variables to provide additional template data. You'll learn about the syntax of SwiftHtml, how to iterate through objects, how to check optional variables, and how to extend a base template to provide a reusable framework for our website, and finally, we'll build a simple blog layout with a post, list, and detail pages.

**Chapter 4: Getting started with Fluent** Here you'll learn about the Fluent ORM framework and the advantages of using such a tool instead of writing raw database queries. We'll set up Fluent, powered by the SQLite driver, and model our database fields using property wrappers in Swift. We're going to provide a seed for our database, get familiar with migration scripts, and make some changes on the website so it can query blog posts from the local database and render them using view templates.

**Chapter 5: Sessions and user authentication** We're going to focus on building a session-based web authentication layer that users will be able to use to sign in using a form, and with which already logged in users will be authenticated with the help of a session cookie and persistent session storage using Fluent. In the second half of this chapter, I'll show you how to create a custom authenticator middleware that'll allow you to authenticate users based on sessions or credentials. 

**Chapter 6: Abstract forms and form fields** Building forms is all about creating an abstract form builder that we can use to generate the HTML forms. We're going to define reusable form fields with corresponding context objects using a model-view-like architecture. This will allow us to compose all kinds of input forms by reusing the generic fields. In the second half of the chapter, we're going to talk about processing user input and loading and persisting data using a protocol-oriented solution. Finally, we're going to rebuild our already existing user login form by using those components.

**Chapter 7: Form events and async validation** Next, we're going to work a little bit on our form components. We're going to implement more event handler methods and you're going to learn the preferred way of calling them to build a proper create or update workflow flow. The second half of the chapter is all about building an asynchronous validation mechanism for the abstract forms. We're going to build several form field validators and finally, you'll see how to work with these validators and display user errors to improve the overall experience.

**Chapter 8: Advanced form fields** This chapter is all about building new form fields that we're going to use later on. You'll learn how to build custom form fields based on the abstract form field class, so by the end of this chapter, you should be able to create even more form fields to fit your needs. We're also going to introduce a brand new Swift package called Liquid that's a file storage driver made for Vapor. By using this library, we're going to be able to create a form field for uploading images.

**Chapter 9: Content Management System** Here you'll learn how to build a basic content management system with an admin interface. We're going to create a standalone module for the admin views that'll be completely separated from the web frontend. The CMS will support list, detail, create, update and delete functionality. Models are going to be persisted to the database and we'll secure the admin endpoints by using a new built-in middleware.

**Chapter 10: Building a generic admin interface** This chapter is about turning our basic CMS into a generic solution. By leveraging the power of Swift protocols, we're going to be able to come up with several base controllers that can be used to manage database models through the admin interface. This methodology allows us to easily define a list, create, update and delete controllers. By the end of this chapter, we're going to have a completely working admin solution for the blog module.

**Chapter 11: A basic REST API layer** Next, you'll learn about building a standard JSON-based API service. In the first section, we'll discuss how to design a REST API then we'll build the CRUD endpoints for the category controller. We'll also talk a bit about the HTTP layer and learn how to use the cURL command-line utility to test the endpoints. You'll discover why it's a better practice to use standalone data transfer objects (DTOs) rather than expose database models to the public.

**Chapter 12: Building a generic REST API** This chapter contains useful materials about how to turn our REST API layer into a reusable generic solution. We're going to define common protocols that'll allow us to share some of the logic between the admin and API controllers. The first part's going to be all about the controller updates, but later on in this chapter, we're also going to improve the routing mechanism by introducing new setup methods for the route handlers.

**Chapter 13: API protection and validation** Here you'll learn about making the backend service more secure by introducing better API protection and validation methods. The first part is about user authentication using bearer tokens. We're going to create a new token-based authenticator and guard the API endpoints against unauthenticated requests. The second part is going to be all about data validation using the async validator logic that we created a few chapters before. In the very last section of this chapter, we're going to introduce some additional lifecycle methods for the controllers.

**Chapter 14: System under testing** For testing, you'll learn the brand new **XCTVapor** framework. First, we'll set up the test environment, write some basic unit tests for our application, and then run them. Next, we're going to dig a little bit deeper into the **XCTVapor** framework so you can see how to write more complex tests. In the last part, you'll meet a super lightweight and clean testing tool. The **Spec** library will allow us to write declarative specifications for our test cases.

**Chapter 15: Event-driven hook functions** After that, we're going to eliminate the dependencies between the modules by introducing a brand new event-driven architecture (EDA). By using hook functions, we're going to be able to build connections without the need of importing the interface of one module into another. The EDA design pattern allows us to create loosely coupled software components and services without forming an actual dependency between the participants.

**Chapter 16: Shared API library packages** Last but not least, this chapter teaches you how to separate the data transfer object (DTO) layer into a standalone Swift package product: this way you'll be able to share server-side Swift code with client apps. In the first part of the chapter, I'm going to show you how to set up the project then we're going to add access control modifiers to allow other modules to see our DTOs. The second half of the chapter is going to give you some really basic examples of how to perform HTTP requests using the modern Swift concurrency APIs.


## Do you have any questions?

Feedbacks, release schedule, beta period anything you would like to know?

Feel free to send me your thoughts so I can improve both the samples and the book.

Please don't hesitate to contact me using the options below.

## Contact details

- Web: [theswiftdev.com](https://theswiftdev.com)
- Email: [mail.tib@gmail.com](mailto:mail.tib@gmail.com)
- Twitter: [@tiborbodecs](https://twitter.com/tiborbodecs)

I hope you'll enjoy reading my book.

Thank you for your support.

