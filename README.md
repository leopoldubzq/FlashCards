# FlashCards

Flashcards is an educational app that helps you learn more effectively. Create flashcards in very easy and convenience way. Check your knowledge with a simple and modern swipe left/right functionality. You have 100% control over your flashcards by creating, editing, retrieving or deleting data.

## Core Data

Flashcards app uses Core Data to create, edit, delete and retrieve data.

## Programmatic UI

I created User Interface 100% programmatically without using Storyboard. 

## Extensions

To make life easier I used auto layout extensions file which helped me creating UI way more faster. Also, extension file contains custom classes like "CustomTextField" to prevent creating redundant data.

## Managing with memory leaks

To manage with memory leaks application uses delegates defined as weak variable or "weak self" in completion blocks to prevent retain cycle.

## Model, View and ViewController

I used MVC design pattern to seperate view and model from ViewController.

## Form validation
The application uses form validation to not let user possibillity to create empty flashcards or groups. The form validation is created with RxSwift and RxCocoa framework.
