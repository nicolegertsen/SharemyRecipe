DESIGN DOCUMENT
=================

The code is written in Xcode. 

**MainViewController** - description 

————————————————————————————————

When a user uses the app, MainViewController opens. When a user opens the application for the first time, he or she is asked to log in with a Facebook account. If the user quits the application, the next time he or she does not have to log in again; the user is immediately directed to the next page. When a person is logged in, he or she is able to add recipes either by selecting one from the Yummly API or by inserting one manually. A user should be able to share a recipe on Facebook. 

**MainViewController** - code

—————————————————————————

*FBLoginView UI control*

* Install the Facebook SDK for iOS.

* Create app on Facebook and obtain a Facebook App ID.

* Add the Facebook SDK to the Xcode Project. Configure .plist with a key called FacebookAppID and a key called FacebookDisplayName and an array called URL types. 

* Create a login UI Control by adding a View object to the MainViewController. Change the Class property to FBLoginView. 

* Make sure that the FBLoginView class is loaded before the view is shown and process the response you get from interacting with the Facebook login process. 

* Ask the user for read permissions. 

* Receive notifications on events that affect FBLoginView by conforming to the FBLoginViewDelegate protocol and implementing certain methods. 

*UITableView*

* Create a UITableView on the MainViewController. The user is able to add a new recipe to the table.  

* If a cell in the table is empty the user can touch the cell and two options appear. The user can select „Add recipe from Yummly” or „Add own recipe”. 

* If the user selects „Add recipe from Yummly, he or she ……??????

* If the user selects „Add own recipe” he or she is directed to an empty DetailViewController where he or she can enter: Title of the recipe, Ingredients, Description and picture (optional). 

* If a cell is not empty (a recipe is submitted) the user can view the content by pressing it. The DetailViewController opens. 

**DetailViewController** - description

——————————————————————————————————————

When a user wants to view the content of a recipe, the DetailViewController opens. In this view the ingredients, a description of preparation and a picture of the dish (optional) are shown. 

**DetailViewController** - code

———————————————————————————————

* Create a navbar that shows the name of the recipe.

* Create a UITableView that shows the needed ingredients. 

* Create a textfield that shows the description.

* Create an imageView that shows a picture of the dish (optional). 



