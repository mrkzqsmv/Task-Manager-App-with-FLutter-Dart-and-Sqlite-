# To do List

This application is developed using Flutter and Dart. The Shared Preferences package is utilized to store the tasks created in the application.

The app allows users to create tasks, view existing tasks, and examine task details. Additionally, it provides features to delete individual tasks and all tasks using the "Delete" button at the top.

Tasks are stored using the Shared Preferences package, and a notification popup appears each time a task is added or deleted. You can confirm or cancel the action by selecting the "Cancel" or "Okay" options in the popup.

While tasks can also be stored in SQLite, initializing the database each time the app is opened may slow down the application. Therefore, for a more advanced version of the app, considering storing tasks in Firebase could be a viable option.

