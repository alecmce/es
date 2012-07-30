# Introduction (0 - 5 mins)

    Hello. My name is Alec McEachran. I'm an game and interactive software developer. I've worked in Silicon Valley for a few years now, for Slide, Gaia, Play Studios and just recently for Kabam. Right now in my day job I'm working on a great game called Realm of the Mad God. You should check it out, it's awesome. But it wasn't written by me, and it isn't written with an Entity System on the front-end, so check it out some other time.

    I want to talk to you today about Entity Systems. Some of you may know a lot about them, others little-to-nothing. That's ok; I'm going to keep this relatively high-level, talk about the ideas behind Entity Systems, what they do and why they're useful.

# 

# Seeking Structure (5 - 10 mins)

    Our brains are systems that receive and aggregate extraordinary amounts of data into a sophisticated model of the world. Our brains are self-reflexive: they can and do model their own functioning and the functionality of others'. The story of how magnificently adept we are at imposing accurate structures onto the world is the story of human evolution.

    Developers 

# Space Invaders (10 - 15 mins)

    Imagine being asked to build space invaders from scratch. You've been programming in an object-oriented paradigm for several years; perhaps you've even studied it at university. You know exactly where to start. There are two main objects in Space Invaders: Aliens and a Spaceship.

    The Aliens are arranged in a grid structure. The aliens in the grid move from left-to-right until the hit the edge of the screen, then they move down a little and change direction to move right-to-left. We can describe that using an AlienGrid. The bottom row of Aliens fire Bullets down towards the Spaceship. If the bullets collide with the Spaceship, the player loses a life.

    The Spaceship moves left and right and can fire bullets according to user input. If the bullets hit the aliens then that alien is destroyed. All the aliens must be destroyed to complete the level. As the Aliens move down, if an Alien collides with the Spaceship then the player loses a life.

    That's the whole game.
    

# RobotLegs (15 - 20 mins)

    Frameworks / Toolkits
    People who dislike frameworks argue that they impose a structure
   
    ## RobotLegs and Games

# Rethinking Structure (20 - 25 mins)

    Flexible structures are about design processes!

Uncle Bob - Refactor 'til you drop?

# Entity Systems (25 - 30 mins)

    ## The Future of Entity Systems




=====================================================================================================================================




Programming is the creation of logical structures that instruct computers to operate such that they exhibit intended behaviors.

When we start to write a program, we start with an intended behavior and  work backwards to model it using logical structures.


Programming is about two things: finding a structure in code that sufficiently represents a structure 

interface Entities
{
    
    function create():Entity;

    function getCollection():Collection;

}

interface Entities
{
    
    function add(entity:Entity):void;

    function remove(entity:Entity):void;

    function manage(collection:Collection):void;

    function release(collection:Collection):void;

}



Future of Entity Systems
========================

Projects go through various stages of maturity. With the upcoming release of RobotLegs 2, it will have achieved a level of maturity and stability that makes it the definitive implementation of MVC.

By comparison, Entity Systems are incubating. However they do have an advantage that RobotLegs will struggle to achieve: portability...

So what are the the features we'll see in the future?

• Hamcrest-style (or just Hamcrest) matchers to retrieve one or many entities.
• Ubiquitous IO
• How do we handle interfaces, subclasses and superclasses
• RL/DI style dependency injection for collections and other structures