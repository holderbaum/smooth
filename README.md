Smooth
======

Smooth is a library, wrapped around the amazing haml-sass parser, to generate sexy html-slides from a haml file.

Abstract
--------
*1.* Create a @template.haml@ in your working directory for your slides:

    - layout :default
    
      - about do
        -title    "My first Slides"
        -subtitle "Generated with Smooth"
        -author   "Your Name"
        
      - slides do
        -title
        -slide "Title of the first Slide" do
          %p This is something I wan't to say here
        -section "Syntax highlighting", :desc => "Follows on the next slide"
        -slide "Syntax highlighting" do
          %p we use the blackboard TextMate theme here
          ~ code :ruby, :blackboard  do
            :plain
              class Slides
                def present
                  "I present my slides, now!"
                end
              end

*2.* Call @smooth > index.html@

*3.* Watch the result of the File above: 

The helpers
-----------

Basically, it provides a bunch of useful and slide-related helpers and enhancements to haml.

### Components mechanism

Smooth implements a component-helper, that generates dynamic methods in your template.

Example template:
    .my-template
      = header "my title", :subtitle => "something special" do
        %p content of the header

If the method `header` is not found in the render context, the component_resolver searches in configurable directories for component files.
If such file is found (`[gemdir]/share/components/header.haml` or `[your_project]/components/header.haml` in this specific case) it is rendered.

The first argument is passed as an local variable called `title`, the block is accessible through `yield`.

The optional arguments hash creates variables identifyed by the key and set to the value.
(Since these arguments are optional, they should only be used after checking their definition)

So, the header-component could look like this:
    .header
      %h1= title
      %h2= subtitle if defined? subtitle
    
      .content= yield

*Note:* Components are nestable.

### Assets mechanism

### Helpers


How to use it?
--------------

Installation
----------------

Deps: `apt-get install libonig-dev`
