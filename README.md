# JPMChaseChanllenge

![JPM_Record](https://user-images.githubusercontent.com/83689709/205482477-0703b93e-afe1-491d-a61a-f1808fe3893e.gif)

Using MVVM-C (coordinator) for the app architecture. Easy navigation controll and integration with SwiftUI views. 
The Coordinator contains certain environments(DI purpose) and viewModels. Then create related ViewControllers and interact with other coordinators.
Coordinators can share same navigator if the ViewControllers underneath would be in the same navigation stack. Otherwise, they can have new navigator.

This app supports iOS 13+. 
