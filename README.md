# Flashcards

Flashcards is an educational app that helps you learn more effectively. Create flashcards in very easy and convenience way. Check your knowledge with a simple and modern swipe left/right functionality. You have 100% control over your flashcards by creating, editing, retrieving or deleting data.

![App presentation](https://user-images.githubusercontent.com/60520591/109629957-acaddc80-7b44-11eb-98d3-ecb9c9c5e688.png)

![501foaaa](https://user-images.githubusercontent.com/60520591/109638322-30b89200-7b4e-11eb-815b-6ab8f5f42c26.gif)

## Core Data

Flashcards app uses Core Data to create, edit, delete and retrieve data.

## Programmatic UI

I created User Interface 100% programmatically without using Storyboard. 

## Extensions

To make life easier I used auto layout extensions file which helped me creating UI way more faster.

## Managing with memory leaks

To manage with memory leaks application uses delegates defined as weak variable or "weak self" in completion blocks to prevent retain cycle.

## Model, View and ViewController

I used MVC design pattern to seperate view and model from ViewController but some files have MVVM architecture. The "View" segment contains custom classes like CustomTextField, CustomCell etc. to prevent creating redundant data.

## Form validation
The application uses form validation to not let give user possibillity to create empty flashcards or groups. The form validation is created with RxSwift and RxCocoa framework.
