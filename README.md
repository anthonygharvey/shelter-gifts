![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg "Made With Ruby")]

# Shelter Gifts - An app that makes it easy to donate items of need **directly** to homeless shelters across the country!

## Description
Shelter Gifts makes it easy for visitors to browse a curated list of items that are needed by shelters across the country.  The list of items come directly from the individual shelters; specifically from their Amazon Wishlists.

Shelters can register with the app and save a link to their Amazon Wishlist.  Once they do, all of the items on their wishlist are added to the Shelter Gifts collection and made available for all visitors to see!

Visitors can browse the list of items needed on the homepage, where each item is presented with a photo, description, price and information about the shelter and their need for the item.  Each item is also presented with a button for visitors to add the item directly to their Amazon cart, where they can purchase the item and have it shipped by Amazon **directly** to the shelter that requested it!

## Demo
App link: <a href="https://shelter-gifts.herokuapp.com/" target="_blank">Shelter Gifts</a>
Shelter Gifts is currently in **demonstration mode** and currently has only one verified shelter, the <a href="https://www.mensshelterofcharlotte.org/" target="_blank">Men's Shelter of Charlotte</a>.  

In demo mode, you can register (or login via Facebook), create a shelter and save an Amazon Wishlist URL and the items will be added to the collection and displayed on the homepage.  The open registration is intended to demonstrate the functionality of the app; however, the app **resets every 5 minutes** to only show verified shelters and their items (the Men's Shelter of Charlotte currently).

## Local Installation
To install and run the app on your local machine:
1. Click the green Clone or download button above and click the copy to clipboard button
2. From your terminal, run `git clone [paste the link from step 1]`
3. Then run `cd shelter-gifts` to navigate to the shelter-gifts directory
4. Run `bundle install` to install the necessary gems and dependencies
5. Run `rake db:migrate` to perform the database migrations
6. Run `rails s` to start a local rails server
7. Go to [localhost:3000](localhost:3000) to view the app!

## Tests
The tests for this app were written with <a href="http://rspec.info/" target="_blank">RSpec</a>, the <a href="https://github.com/stympy/faker" target="_blank">faker gem</a> (to generate fake data for the tests) and the <a href="https://github.com/thoughtbot/shoulda-matchers" target="_blank">shoulda-matchers gem</a> (to write more readable relationship tests).

You can run the entire test specs by running `rspec`, or you can perform tests for a particular file by running `rspec spec/folder_name/file_name.rb`.

## Development Approach
If you'd like to know more about my approach to developing the app, feel free to check out the <a href="https://anthonygharvey.com/projects/shelter_gifts" target="_blank">article</a> I wrote on my website and the Shelter Gifts <a href="https://shelter-gifts.herokuapp.com/about" target="_blank">about page</a>.
