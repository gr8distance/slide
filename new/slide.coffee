class Human
  
  constructor : @name ->
  
  name : ->
    console.log @name
  
  

human = new Human("Yuuji")
human.say()