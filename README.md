# README

## Chess App Workflow

*1. Backlog*  
* Choose task from backlog
* "git pull origin master" to pull down latest code
* ****bundle exec rake db:reset (locally it drops, creates, migrates, & updates the seed.rb file for the DB)***
* Create branch in local environment from "master" (never from an existing branch) ---> ‘git checkout -b NAME_OF_BRANCH’
* Push to Github ‘git push origin NAME_OF_BRANCH’
* Attach branch on Trello
* Make sure card is moved to "in progress" on Trello

*2. In Progress*  
* Work on task
* Once task is finished
* Make commit
* Push to github
* Open Pull Request (PR)
* Add all devs as reviewers
* Finish creating PR
* Attach PR on Trello
* Label card as "Pending code review" on Trello
* Move card to "Review" on Trello  

*3. Review*
* Have someone review PR and if "Changes Requested" (reviewer should test locally)
* Move card from "Review" to "In progress" on Trello
* Change trello label status to "Changes requested" on Trello
* Once changes are made and ready for code review, move to "Review" and add "Pending code review" label on Trello
* Repeat process until PR is accepted

*4. Merge into Master branch*
* Once code is reviewed on GitHub and looks good, another dev member will merge code into master branch
* Move card into "Testing" block on Trello and add "Pending manual testing" label 
* Code will be tested locally under master branch by other dev members(add comment on Trello to indicate test works)
* If code works then deploy to heroku locally and move card to "Complete" block
* If code doesn't work then label card "Changes requested" and move back to "In progress" 

