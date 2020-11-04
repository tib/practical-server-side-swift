# 📖 Practical Server Side Swift 

Vapor 4 code samples for the [Practical Server Side Swift book](https://gumroad.com/l/practical-server-side-swift) available on [Gumroad](https://gumroad.com/l/practical-server-side-swift).  

## Chapter 1: Introduction

This chapter is an introduction to the Server side Swift world, explaining the evolution of Swift as a universal programming language. We'll talk about both the strengths and weaknesses of the language and discuss why Swift is a good choice to build backend applications. We'll explore the Swift ecosystem and the open-source movement that made it possible to create the necessary tools on Linux to turn Swift into a server side language. You'll get introduced to Vapor, the most popular web application framework that we're going to use in this book.

## Chapter 2: Hello Vapor

This chapter contains detailed instructions about how to install all the required components to build server side Swift applications both on Linux and macOS. You'll meet some command line tools that can help your every day life as a backend developer and we'll create our very first Vapor project using the Swift Package Manager. We'll also set up Vapor toolbox a handy little tool that can help you to bootstrap projects based on a template. In the very last section we will briefly take a look at the architecture of a Vapor application.

## Chapter 3: Building a website using Leaf

In this chapter we're going to build our first website using the Leaf template engine. We are going to write some basic HTML and CSS code and learn how to connect Swift objects with the template engine using contexts. You'll learn about the syntax of Leaf files using variables, conditions, how to iterate through objects and we will extend a base template to provide a reusable frame for our website. We'll build a blog layout with post list and detail pages.

## Chapter 4: Creating a blog database

You'll learn about the Fluent ORM framework and the advantages of using such tool instead of writing raw database queries. We'll setup Fluent powered by the SQLite driver, and model our database fields using property wrappers in Swift. We are going to provide a seed for our database, get familiar with migration scripts and make some changes on the website, so it can query blog posts from the local database and render them using Leaf.

## Chapter 5: User authentication using sessions

In this chapter we are going to focus on building a session based web authentication layer. Users will be able to sign in using a form, and already logged in users will be detected with the help of a session cookie and a persistent session storage using Fluent. The final part of this chapter is about refactoring our view layer and preparing everything for a more robust form building solution that we will implement in the next chapter.

## Chapter 6: Content Management System

This chapter is all about building a content management tool with an admin interface. We are going to create a module for the admin views completely separated from the web frontend. The CMS will support list, create, update and delete functionality with reusable forms based on Leaf templates and validated using Swift code. Models are going to be persisted to the database and we'll secure the admin endpoints by using middlewares.

## Chapter 7: Content relations and file uploads

We are going to extend the capabilities of the CMS by implementing a relationship selector for post categories and a file uploader. You will learn how to use the multipart-form-data type and write a basic asset manager using the non-blocking API from the SwiftNIO package. This time we'll store and host files in the public folder of the application. You can also learn a bit more details about event loops, route handlers and other form fields.

## Chapter 8: Reusable web admin interfaces

In this chapter we will apply the same principles for the category model that we used to build our CMS for the blog posts. By observing the patterns in our code we are going to refactor all the code duplications. We will create a generic protocol oriented solution that we can use in the future if it comes to building admin views. In the very end of this chapter we are going to replace what we've made with an even better third party solution.

## Chapter 9: Building a generic REST API

You'll learn abut building a standard JSON based API service. In the first section we will discuss how to design a REST API, then we will build some building CRUD endpoints in a generic, protocol oriented way. We'll talk a lot about the HTTP layer, learn how to use the cURL command line utility to test the endpoints. You'll discover why it is a bad practice to use database models as API objects and, finally, we will protect the routes using a token based auth system. 

## Chapter 10: Shared libraries & API design

In this chapter we are going to split up some of our code into a separate library. This will allow us to use the library in other applications as well. You will learn how to create a new Swift Package from scratch and use it as a local dependency. We will move some of the API layer into the newly created package and reconnect it as a dependency. We are also going to talk about Data Transfer Objects. In the very last part I'll show you how to perform a HTTP request on the server side using the built-in async HTTP client.

## Chapter 11: System under testing

This chapter is about learning the brand new XCTVapor framework. First we'll set up the test environment, write some basic unit tests for our application and run them. Next we are going to dig a little bit deeper in the XCTVapor framework so you can see how to write more complex tests. In the last part you will meet with a super lightweight and clean testing tool. The Spec library will allow us to write declarative specifications for our test cases.

## Chapter 12: Don't repeat yourself

In this chapter we are going to replace the content API and view related files with external Swift packages, this way we can focus more on our business logic and worry less about building reusable components. It is also a great opportunity to refactor Leaf files and take advantage of the new features, so we don't have to copy & paste template snippets again. We'll also refactor the existing modules by using ViperKit and learn how to quickly bootstrap a new one using templates and a small command line utility tool written in Swift.

## Chapter 13: A modular iOS client

This time we are going to build a small iOS application in a modular fashion using Xcode. First, we will build a communication service layer using the previously created MyProjectApi package and the brand new Combine framework as a dependency. We will also learn how to generate VIPER modules using the Swift template tool. We will display a basic list of posts using the UIKit framework with the help of a table view. We are going to programmatically create all of the user interface, including auto layout constraints and custom views.

## Chapter 14: Sign in with Apple

This chapter is about integrating the Sign in with Apple service into the website and the iOS client application. You'll learn about how to set up identifiers and keys using the Apple developer portal. We are going to talk about the fundamental concepts of the sign in flow. We will configure the JWT library to sign and verify JSON Web Tokens as part of the Vapor framework. We are also going to use the public JWKS validation service by Apple and extend our user module.

## Chapter 15: Push notifications

In this chapter we are going to integrate the Apple Push Notification Service (APNs) both on the client and the server side. We are going to learn how to register for remote notifications, send device tokens to the backend and request for authorization using the UserNotifications framework. We are going to create a very basic admin interface for sending push messages using the Vapor APNS package.

## Chapter 16: Infrastructures

In this chapter we're going to upgrade our infrastructure. We'll learn how to move away from the file based SQLite database and connect to a PostgreSQL database server. We'll also use a new Liquid driver to store files on AWS S3. Next we will containerize our backend server by using Docker. After that we'll setup GitHub Actions (a continuous integration service) to run automated unit tests. Finally we configure a container repository service (ECR) on AWS to push the container images of the project and we will create a fully automated delivery system to deploy our application to the cloud with the help of ECR, Fargate (ECS) and the RDS infrastructure. As you can see we have a lot to do, so let's get started.


## Do you have any questions?

Feedbacks, release schedule, beta period anything you would like to know?

Feel free to send me your thoughts so I can improve both the samples and the book.

Please don't hesitate to contact me using the options below.

## Contact details

- Web: [theswiftdev.com](https://theswiftdev.com)
- Email: [mail.tib@gmail.com](mailto:mail.tib@gmail.com)
- Twitter: [@tiborbodecs](https://twitter.com/tiborbodecs)

I hope you'll enjoy reading my book.
