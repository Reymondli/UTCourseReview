## University of Toronto Course Review (iOS Platform)
Udacity iOS Nano Degree Project 5 - "Your Decide!"
## Motivation of the project
As university students, course enrollments are critical. Some courses inspires students for their future career and research area. Some however, not that useful and/or not worth taking in certain situation. To find out whether a course is valuable, one convenient way is to hear what past students have to say about it. Are they interest? hard? and most importantly, are they useful?

## Introduction
University of Toronto Course Review (UTCR) is based on this thought and is designed specifically for the campus i'm studying at - University of Toronto. It has both iOS version and website version http://utcr.flowintent.com/#/. Similar to "Rate My Professor", this platform gives student chance to find out detail description for courses provided by University of Toronto. Students can also read any comments others made, as well as post their own comment based on their thoughts and experience. Comments including student's personal thought, professor who taught him/her, and rating of the course (hardness, usefulness and attractiveness).

For this iOS App, student can further add/remove courses into/from their favorite list as a reference for course enrollment.

## Development Environment
Mac OS X Sierra

IDE: Xcode 8

Language: Swift 3

Device: All device running iOS 10.3

## Downloading and Installation
Simply download this project (https://github.com/Reymondli/UTCourseReview) and open "UofTCourseReview.xcodeproj" using Xcode 8 or later version.

### For running on Simulator and/or iOS Device:
To run UTCR in Simulator, choose an iOS simulator (e.g. iPhone 7 Plus, iPad Air, or iPhone 6) or your connected iOS device from the Xcode scheme pop-up menu, and click Run. Xcode builds the project and then launches the most recent version of the app running in Simulator on your Mac screen

## Function Detail
For this iOS App, UTCR has two tab - Search and Favorite. Search contains all the functionality from UTCR Website (Search, Get Review and Post Review); For favorite tab, student can further add/remove courses into/from their favorite list as a reference for course enrollment.

### Search Tab 
### Step 1: Search Page:
When App is launched, the first page user sees is Search Page with a textfield and a search button. User is supposed to type in any UofT course code inside textfield. e.g. APS105 is a first year Applied Science Course; ECE331 is a third year Electrica and Computer Engineering Course. If user is not sure about complete course code, he/she can type part of it (e.g. ECE or ECE1 instead of ECE110) and search for it.

More course can be found here: https://fas.calendar.utoronto.ca 
and here: https://portal.engineering.utoronto.ca/sites/calendars/current/Course_Descriptions.html

Users will get error when they try to search for invalid course code and/or no network connection or leave textfield blank, etc.
![Alt text](/Screenshots/IMG_0021.PNG?raw=true "Search Page")
![Alt text](/Screenshots/IMG_0023.PNG?raw=true "Search Result Page")

### Step 2: Search Result Page:
After user type either part of course code or complete code and click search (without getting an error), he will be directed into Search Result Page. This page shows any matching result(s) based on user's search. For example, if user typed ECE1 in Step 1, search result page will show him list of courses containing "ECE1", e.g. ECE110H1S, ECE101H1S, etc. User can simply select the row they want to view course review, or click "Back" button on top left corner and re-do Step 1.

### Step 3: Course Review Page:
Upon selection of course, the detail of this course will be displayed in Course Review Page. The page contains: Complete Course Code in title, course name and description and average ratings in textView, "Favorite" button for saving the course to favorite list,"New Comment" button for adding a review for the course, and a list view of comments submitted by others.

![Alt text](/Screenshots/IMG_0024.PNG?raw=true "Course Review Page")

### Step 3.1: Click on a comment
For any course that has comment(s) posted by others, user can click on these comment to see detail, including complete text of the comment, the year reviewer took the course, ratings(hardness, usefulness and interest) he gave, name of professor who taught the course, and the date review posted this comment. Once finished reading, user may click top left corner button (named as course code) to go back.

### Step 3.2: Click on New Comment Button
If user has already taken the course or has some idea about the course, he/she can add new comment for the course, by selecting "New Comment" button from Course Review Page (Step 3). 
Once clicked, user will be brought to Add Review Page. There are 6 fields that user MUST provided in order to submit the review: Professor Name, Year of taken, Hardness, Useful, Interest, Comment. Once all fields are filled, simply click "Submit" button to submit.

#### Note: as a protection mechanism on UTCR Website, user from each IP can only submit ONE review to a course. Second time of review post won't be allowed.

![Alt text](/Screenshots/IMG_0025.PNG?raw=true "Course Review Page")

### Step 3.3: Click on Favorite Button
From course review page (Step 3), user can add this course to favorite list, simply click the "Favorite" button. Once completed, "Favorite" button will be disabled for this course.

![Alt text](/Screenshots/IMG_0026.PNG?raw=true "Course Review Page")
![Alt text](/Screenshots/IMG_0027.PNG?raw=true "Course Review Page")

### Favorite Tab
At any time of search period (step 1 -> Step 3), user can always go to Favorite Tab and check what's been saved to their local device. The each row of favorite list contains complete course code and course name. If user no longer need a course and wish to remove it from the favorite list, simply swipe to delete.
#### Note: Course saved in Favorite Tab are presist data, meaning it won't be cleared when user closed the app or device shut down. However, data will disappear if user uninstalled and reinstall the app on device. (Or Clean and Re-build the app on simulator)

![Alt text](/Screenshots/IMG_0028.PNG?raw=true "Course Review Page")

## Credit
UTCR iOS App is designed and developed by Ziming (Rey) Li.

This app uses API from UTCR website. (website designed and developed by Ruihan (Rick) Jia. Data from Cobalt UofT.)

More details of UTCR website can be found here: https://github.com/ruihan-jia/UofTCourseReview



