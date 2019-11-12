# Problem Statement

Given a 10 digit phone number, you should return all possible words or combinations of words from the provided dictionary, that can be mapped back as a whole to the number.

With this we can generate numbers like 1-800-motortruck which is easier to remember than 1-800-6686787825.

The phone number mapping to letters is as follows:

2 = a b c  
3 = d e f  
4 = g h i  
5 = j k l  
6 = m n o  
7 = p q r s  
8 = t u v  
9 = w x y z  

The phone numbers will never contain a 0 or 1.
Words have to be at least 3 characters.

To give you an initial idea, here are some numbers that return (a lot of) results.

6686787825 returns a (long) list with at least these word combinations:

* motortruck
* motor, truck
* motor, usual
* noun, struck
* not, opt, puck

2282668687 returns a (long) list with at least these word combinations:

* catamounts
* acta, mounts
* act, amounts
* act, contour
* cat, boot, our

The conversion of a 10 digit phone number should be performed within 1000ms.

Please create a public github repo for this project under your own account. Make an initial commit to mark when you start, and commit each step during development. Try to commit at least once per hour to the repo. Doing this will allow us to see the steps you took to come to the solution, and how long it took you to do so.

You solution should contain a library with at least a public method that we can call with a 10 digit number, which returns an array with all results. We will use this method to test a set of random numbers and verify the output.

The complete solution should include documentation and unit tests which should at least include the two provided examples.

You have 8 hours to complete this assignment in Ruby. It can be done in under 4 hours, so take the time to do it in a way that showcases your best work.

We hope you understand why we do this. The best way to see what a footballer is capable of is to see them play during a game. Programming is a team effort as well. Your colleagues will have to read and change your code in the future, and vice versa.

You can use a plain text full English Scrabble dictionary such as this one: [Dictionay](https://github.com/jonbcard/scrabble-bot/blob/master/src/dictionary.txt)


