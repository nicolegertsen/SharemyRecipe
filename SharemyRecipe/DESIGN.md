DESIGN DOCUMENT
=================

The code is written in Xcode. 

START VIEW - description 

———————————————————————

When a user uses the app, START VIEW opens. When a user opens the application for the first time, he or she is asked to log in with a Facebook account. If the user quits the application, the next time he or she does not have to log in again; the user is immediately directed to the next page, called MYRECIPE VIEW. 

START VIEW - code

—————————————————

FBLoginView UI control



The user will be able to play right away. A box with dashes in it appears in the middle of the screen. Each dash represents a letter of the word the user must guess. The number of dashes is equal to the number of letters in the word. First of all, the app must generate a word. To generate a word the app uses the database words.plist. 
The GAME VIEW also shows all letters of the alphabet on the screen. The user can guess a letter by touching that letter on the screen. If the letter occurs in the word, the letter will replace a dash on the right place. If the letter does not occur in the word, an element of the hanging man is drawn. Each time a letter is guessed incorrect, the next element is drawn on the screen. Also, the letter disappears from the screen so that it is clear to the user that he or she has already used this specific letter and only not-guessed letters are shown and can be guessed by touching. 
The GAME VIEW also shows how many lives the user has (i.e. chances left to guess the word) and how many correct and incorrect words he or she already guessed. 
On the GAME VIEW the user can go to two other screens, SETTINGS and HIGHSOCRE. When a game is won or lost, the HIGHSCORE screen is automatically displayed. 


GAME VIEW - code

————————————————

	•	Class GAMEPLAY - MainViewController

	Variables:

	⁃	The word
	⁃	The hidden word, represented as a line of dashes; the word the user is trying to guess
	⁃	The guessed letters; the letters that the user has guessed correctly, in their proper position in the word
	⁃	The guess count; the number of guesses a user has left before he or she loses the game
	⁃	The word score; the number of correct guessed words and incorrect guessed words

	Functions:

	⁃	Generate a word from words.plist
	⁃	Display the correct number of dashes 
	⁃	When a letter is touched, it must disappear
	⁃	When a letter that occurs in the word is touched, it should replace a dash on the proper position (if the letter occurs several times in the word, all dashes which represent this specific letter should be replaced by the letter)
	⁃	When a letter that does not occur in the word is touched, the first/next element of the hanging man must be drawn on the screen
	⁃	When a letter that does not occur in the word, the number of lives decreases by 1
	⁃	When the word is guessed within the maximal amount of guesses, the user should be congratulated and gameplay should end; go to HIGHSCORE
	⁃	When the word is not guessed within the maximal amount of guesses, the user should be consoled and gameplay should end; go to HIGHSCORE

	UIButtons:

	⁃	The letters 
	⁃	HIGHSCORE
	⁃	SETTINGS


SETTINGS VIEW - description

———————————————————————————

When a user touches the SETTINGS button, he or she is redirected to SETTINGS VIEW. On this screen the user can change the length of the word to be guessed and the maximal amount of guesses he or she has to guess the word. The allowed range for the first setting is [1, n], where n is the length of the longest word in words.plist. The allowed range for the second setting is [1, 26]. The app comes with default settings; these defaults are set in NSUserDefaults with registerDefaults:. Anytime the user changes these settings, the new values should be stored immediately. Each flipsides’s numeric settings are implemented with a slider control. Each slider is accompanied by one label that reports its current value (an integer). 
On the SETTINGS VIEW the user can press PLAY! to start a new game. He or she is directly redirected to GAMEPLAY. 

SETTINGS VIEW - code

————————————————————

	•	FlipsideViewController SETTINGS
	•	NSUserDefaults with registerDefaults
	•	Slider controls 
	•	UIButton PLAY!

HIGHSCORE VIEW - description

————————————————————————————

When a user touches the HIGHSCORE button, he or she is redirected to HIGHSCORE VIEW. On this screen the user can view his or her history of played games. The word is shown accompanied by the number of guesses needed. When the user failed to guess the word within the maximal amount of guesses, number of guesses shows: FAILED. For this features another database is needed which keep track of how many guesses it took a user to guess a certain word; it gives a value to this word. 

HIGHSCORE VIEW - code

—————————————————————

	•	model History
	•	ViewController HIGHSCORE


![Alt text](/doc/DIAGRAM.png?raw=true "Diagram")