Smooth
======

What is it?
-----------
Smooth is a library, wrapped around the amazing haml-sass parser, to generate sexy html-slides from a haml file.

Basically, it provides a bunch of useful and slide-related helpers and enhancements to haml.

### Components mechanism

Smooth implements a component-helper, that generates dynamic methods in your template.

Example template:
<pre>
<code>
.my-template
  = header "my title", :subtitle => "something special" do
    %p content of the header
</code>
</pre>

If the method `header` is not found in the render context, the component_resolver searches in configurable directories for component files.
If such file is found (`[gemdir]/share/components/header.haml` or `[your_project]/components/header.haml` in this specific case) it is rendered.

The first argument is passed as an local variable called `title`, the block is accessible through `yield`.

The optional arguments hash creates variables identifyed by the key and set to the value.
(Since these arguments are optional, they should only be used after checking their definition)

So, the header-component could look like this:
<pre>
<code>
.header
  %h1= title
  %h2= subtitle if defined? subtitle

  .content= yield
</code>
</pre>

**Note:** Components are nestable.

### Assets mechanism
### Helpers


How to use it?
--------------

Installation
------------
Deps: `apt-get install libonig-dev`
