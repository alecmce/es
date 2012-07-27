Introduction
============

Hello. My name is Alec McEachran. I'm an interactive software developer / game developer. I've worked in Silicon Valley for about three years now, for Slide, Gaia, Play Studios and just recently for Kabam. Right now in my day job I'm working on a great game called Realm of the Mad God. You should check it out, it's awesome. But it wasn't written by me, and it isn't written with an Entity System on the front-end, so check it out some other time.

I want to talk to you today about Entity Systems. Some of you may know a lot about them, others little-to-nothing. That's ok; I'm going to keep this relatively high-level, talk about the ideas behind Entity Systems, what they do and why they're clever.

Coding is About Structure
===================================================

Obviously. The structures that we create model some aspect of the world that we want to automate, visualize, persist, subvert... the list 

Uncle Bob - Refactor 'til you drop

MVC





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