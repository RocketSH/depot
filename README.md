# shu-han-training

This is a learning project with 6 tasks:
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->
    - [5.1 Profile Page](#51-profile-page)
    - [5.2 Basic Dynamicity of the Page and Actions](#52-basic-dynamicity-of-the-page-and-actions)
    - [5.3 Basic Rails Application](#53-basic-rails-application)
    - [5.4 Basic Rails Application - The Models](#54-basic-rails-application---the-models)
    - [5.5 Basic Rails Application - MVC + Routes](#55-basic-rails-application---mvc--routes)
    - [5.6 Movie Night Application](#56-movie-night-application)

<!-- /code_chunk_output -->
---
### 5.1 Profile Page
> see result on git branch: _**dev/task1&2\_\_profile-page**_

Please execute this task using **basic HTML** and **CSS**. The page is intended to be completely **static**.

Build profile page (like a simple static page with a single photo of you/or some avatar, with background) It should contain details about the person/avatar such as:

- Name
- Birth date
- Location
- Basic Bio
- Description of hobbies

Each of these items should 'logically' be its own section with visual separation to the rest of the sections. Think about what are the best HTML TAGS to us to achieve that and why?
Think about how to style this (Feel free to style it whichever you wish, it would be extra cool to have this page styled multiple times. Think of it as a single HTML page - with multiple CSS files that upon replacing product different visual result)

Please familiarize yourself with the grid and elements positioning

### 5.2 Basic Dynamicity of the Page and Actions

> see result on git branch: _**dev/task1&2\_\_profile-page**_

Building on the previous task. Add the following features to your page:
"**Send a Message**" button, which should open a **modal** window. The modal window should allow for filling in "subject" and "message body".

First one is recommended as a text field and the second one as a text area (as you intend to write more in the body of the message).

The modal should also have a "**cancel button**" that closes it, plus the "send" button that sends the message. Message sending functionality is of course non-existent, but it goes beyond this task in this exercise. It is however important to show a "**visual clue**" that message was sent, please consider using the flash messages feature. (here is what they are and how they look like) Let your flash message suggest that it's a successful message send with a proper text and visuals to support that.

### 5.3 Basic Rails Application

> see result on git branch: _**dev/task3\_\_agile-web-development**_

![Tutorial product mindset](https://i.imgur.com/SpdCg86.png)

Start working on the "Agile Web Development" book, the intention of this and next couple of exercises is to walk you through:

- Folder structure of the Rails project
- Understand where familiar HTML, CSS, JS files live in it
- Show you the basic of the request flow (including routing)
- Use `RSpec` instead of 

Anything else is beyond this section, please don't be put off if you don't understand something or if you copy commands following the book. The purpose will be met and you will grow knowledge of these core basic concepts mentioned above.

### 5.4 Basic Rails Application - The Models

In this tutorial we will sit down with a nominated mentor to walk you through the interactions between models. Here we will make a detour for a lesson or two from Rails and dive into the wonderful world of the **Databases** and **SQL** (Structured Query Language). Ideally by the end of this you should be able to distinguish between:

- Different data types
- What is a table vs what are the columns
- Basic relations (1-to-many)
- How all of the above is reflected inside the ActiveRecord Model, why do we do that and how do we use it in day-to-day Rails apps.

If you want to better prepare for this lesson, or after it read on and better understand certain topics I suggest to follow up with the following materials:
[khanacademy: SQL](https://www.khanacademy.org/computing/computer-programming/sql)

### 5.5 Basic Rails Application - MVC + Routes

In this section I would like you to dive in and understand **routing** and **MVC** inside the Rails application. Before moving in to the task it would be helpful to familiarize yourself with the following section: https://guides.rubyonrails.org/routing.html

### 5.6 Movie Night Application
> see result on git branch: _**dev/task6\_\_vovote**_

- First of all, consult with Lukasz (playing role as PM) about the requirements in advance, so we can do a bit of a drawing on piece of paper to better understand different aspects of the app
- build an app that allows admins (using **ActiveAdmin** gem) to put the videos into the DB
- We can then have a **movie night session**, where for each session individually people vote for the one they want to watch together. (if the app is built in a generic way - we could also use that for food voting for weeklines - think about it during making your design decisions in the code).
