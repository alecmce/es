# Introduction (0 - 2 mins)

Hello. My name is Alec McEachran. I'm an game and interactive software developer. I've worked in Silicon Valley for a few years now, for Slide, Gaia, Play Studios and just recently for Kabam. Right now in my day job I'm working on a great game called Realm of the Mad God. You should check it out, it's awesome. But it wasn't written by me, and it isn't written with an Entity System on the front-end, so check it out some other time.

I want to talk to you today about Entity Systems. Some of you may know a lot about them, others little-to-nothing. That's ok; I'm going to keep this relatively high-level, talk about the ideas behind Entity Systems, what they do and why they're useful.

# Object Oriented Thinking (2 - 10 mins)
 
## Space Invaders

Imagine that a boss or a client asks you to build a new implementation of Space Invaders. Where would you start? 

[PLAY NAIVE-OOP-INVADERS]

If you think about the structure of Space Invaders for just a few seconds, two very obvious objects jump out at you: the Spaceship and the invaders, or Aliens. The core of the SpaceInvaders game is a collection of Aliens that are 'attacking' by methodically moving down the screen towards the Spaceship. They try to shoot the spaceship, you control the spaceship and try to shoot the aliens.

So we create the Alien class and the Spaceship class. Then we remember that Aliens are arranged in a grid and move in formation, so we create an Aliens or AlienGrid class. It makes total sense. 

Let's say you start with the spaceship. You want to be able to see it so maybe you add a draw method, or if you're targetting the Flash Platform maybe you extend Sprite. You need to be able to move it, so you add user-controls to move it left-and-right. You need to be able to shoot bullets so you create the ability to shoot bullets. That creates bullets which go up until they're off the screen, then you remove them.

At this point you're ready for Aliens. You draw Aliens. You work out how to keep the Aliens moving together in a grid formation and you randomly pick one of the Aliens at the bottom of the grid to shoot at regular intervals. Now we have bullets and aliens, so we need to handle collisions.

This is where it starts to get interesting, because now we start to create dependencies between objects. Either the bullet needs to know about the alien, or the alien needs to know about the bullet (or, probably, some third element needs to know about both the bullet and the alien). However this is done, the implementation becomes tricky because of the dependencies created between classes.

## Reflection on Structure

If we had continued to implement Space Invaders in this style, we would have had to cope with Aliens shooting at the Spaceship, so the Spaceship needs to become aware of (depend upon) Bullets. But the Aliens and the Spaceship might collide too so the Aliens need to know about (depend upon) the Spaceship, or vice-versa.

None of this is a problem of course. Dependencies between objects are an expected part of the structure of the code. If there are merely five classes interacting with one another in this way then there is hardly an architectural crisis.

But the architectural problem can be glimpsed I think, in this example. The first few lines of code I wrote bound the Spaceship to Flash's display list. If my client or boss wants to add lots of impressive effects then the player performance isn't going to be good enough. I may need to refactor the code to use blitting or Stage3D.

My collision detection is rudimentary at best. If I continue on the collision detection will be distributed across different classes and right now it too is bound to the display list.

My user-interaction model is tightly coupled to the keyboard. What if I want to deploy to iPad or Android? What if I want to use the mouse?

There are a lot more dependencies here than meet the eye. The more dependencies code has, the slower it takes to change, the more likely it is to break.

"A design is rigid if it cannot be easily changed. Such  rigidity is due to the fact that a single change to heavily  interdependent software begins a cascade of changes in dependent modules." Uncle Bob

## Caveat

Many of you are probably skeptical about the narrative that I've just laid out. You know that if you wrote Space Invaders it wouldn't suffer any of the problems that I've described.

??? WHAT'S MY RESPONSE ??? 

# A Fundamentally Different Approach

## Systems, not Objects

Let's stop thinking about the objects that make up Space Invaders for a moment and start thinking about the processes. What does the programmer need to ensure happens for Space Invaders to be played?

1. Rendering

    Whatever is on-screen, be it Aliens the Spaceship or Bullets, they need to be drawn to the screen somehow

2. Movement

    Most frames, one or more objects in the game are moving around.

2. User-Interaction

    Whatever the inputs, the user has to be able to manipulate the state of the game by some means

3. Collisions

    We need to be able to detect when objects hit each other and react 

## Thinking about the game in this way, 




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