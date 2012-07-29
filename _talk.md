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



========


The Entities class expresses a big simple concept: here is this list of jars, into which you can pour any data you like.
Collections are the expression of categories within the list of jars based on what they contain.
Systems are the manipulation of the contents of the jars in different categories.

      model   <------  command
        command supervenes on 

components    <------  system
        system listens to

  with a change of expectations: commands run every now-and-then. systems run all-the-time.