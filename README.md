# Nifty CMS

A nifty little [Laravel 4.1](http://laravel.com/) CMS bootstrap, implementing the [Nested Set Model](http://en.wikipedia.org/wiki/Nested_set_model)

[Demo](http://nifty.acw-server1.co.uk)


##Caveat Emptor

In active development. 

Initially intended for personal use, it is licensed under the [MIT License](http://opensource.org/licenses/MIT)


## Documentation

* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [Upcoming Features/Changes](#upcoming)


<a name="features"></a>
## Features

* Laravel 4.1, Bootstrap 3.1.1, ckEditor 4.3, ckFinder 2.4
* Admin dashboard based on [Bootstrap Admin Template](https://github.com/onokumus/Bootstrap-Admin-Template)
* Manage pages, posts and users
* Page versioning
* Blog with categories
* Featured images
* Two user levels
* Password recovery



<a name="installation"></a>
## Installation

* Grab the repo and import the sql-dump provided into database: niftycms, with user: niftycms
* Go to / for a demo of the frontend
* Admin dashboard at /dashboard - username: `demo@niftycms.com`, password: `password`
* Enter Mail settings in `app/config/mail.php` - This will be used in password recovery and sending 'Contact us' emails.


<a name="usage"></a>
## Usage

* Page versioning - whenever you edit a page, the system creates a new page and inherits all the ancestors and descendants of the current version.
* Reverting versions - reverting to an older version DOES NOT inherit the ancestors and descendants of the current version.
* If the current version of a page is saved as 'Draft', the previous version (or the one last used, as the case may be), if any, appears in the frontend.
* Posts are not versioned - editing posts simply updates the post
* Use the link feature on a 'Latest News' page, for example, where the summary of an item might link to a document instead of a post page.


<a name="upcoming"></a>
## Upcoming Features/Changes

* Blog comments
* Blog Next/Previous Post
* Gallery Feature 
* 'Order By' and 'Records per page' + Pagination for backend records
* Review the caching feature
* Improve display of pages and posts in the backend.