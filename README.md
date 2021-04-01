# GithubPublicUserApiDemo
 This Project will display the Public Github Users and their details using Github Public API's.
<br />
<p align="center">
    <img src="https://www.pngfind.com/pngs/m/574-5746652_axel-springer-logo-png-transparent-png.png" alt="Logo" width="700" height="150">
  <p align="center">
    This Project will display the Public Github Users and their details using Github Public API's.
  </p>
</p>


<p align="center">
<img src= "https://user-images.githubusercontent.com/52252385/109366608-23707e80-7894-11eb-80ae-cc7e7688e121.png" width="400" >
<img src= "https://user-images.githubusercontent.com/52252385/109366616-279c9c00-7894-11eb-9166-4187efc99172.png" width="400" >
</p>


## Features & Functionality 

- [x] I have used the MVC Architecture to build this application.
- [x] This application used Alamofire for get data from server that is third party library communication.
- [x] This application used sdwebimage third party library for to get image from server,because it get easliy convert image from url to image just in one line code.and also it consumes less time and easily convert.
- [x] This application used github public api to get the data from server and display into the UIView. For Gihub Public Api: [Click here](https://docs.github.com/en/rest/reference) 
- [x] This Application will display the list of user data when user search from any keywords from the Github Api's.
- [x] After display the search result to then user also can see the details of the particluar search result.



## Requirements

- iOS 13.0+
- Xcode 12.4

## Third Party libraries using with cocoapods

#### CocoaPods 
I have used [CocoaPods](http://cocoapods.org/) to install `Library` by adding the `Podfile`:

```ruby
platform :ios, '13.0'
use_frameworks!
pod 'Alamofire'
pod 'SDWebImage'
  ```
