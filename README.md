[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->

<section style="text-align: center">
  <p>
    <a href="https://github.com/miakoiv/Folio">
      <img src="app/assets/images/folio-logo.svg" alt="Folio" width="240">
    </a>
  </p>
  <p>Customer relations and project management for youth work organizations</p>
</section>


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [License](#license)
* [Contact](#contact)



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://leasit.fi/folio)

### Built With

* [Ruby on Rails](https://rubyonrails.org/) - version 5.0
* [Bootstrap](https://getbootstrap.com/docs/3.3/) - version 3.3.6
* [Font Awesome](https://fontawesome.com/v4.7.0) - version 4.7
* [Summernote](https://summernote.org/) - version 0.8.8



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* MySQL database, version 5.6 or newer
* Redis for the ActionCable backend, see `config/cable.yml`
* ImageMagick for scaling image uploads

### Installation

1. Clone the repo and run Bundler to install required gems

  ```sh
  git clone https:://github.com/miakoiv/folio.git
  cd folio
  bundle
  ```

2. Define environment variables

  Folio requires these environment variables to be set:

  * `DATABASE_URL` URL specifying the database, for example `mysql2://user:password@localhost/folio`
  * `MAIL_HOST` hostname for generated links in email, i.e. the server hostname
  * `SECRET_KEY_BASE` encryption key, unique for each Folio instance -- generate one with `rails secret`
  * `OTP_SECRET_KEY` encryption key for One Time Passwords (two-factor authentication) -- generate one with `rails secret`
  * `SHRINE_STORAGE` name for the Shrine storage directory on disk, for example `default`

  Multiple instances of Folio can coexist on a single server by setting up multiple databases and defining different environments for each.


3. Set up and seed the database

  ```sh
  rails db:create
  rails db:schema:load
  ```

  The database seed in `test/fixtures` contains several files with potentionally useful templating data. Feel free to modify these to fit your workflow, then seed the database.

  ```sh
  rails db:fixtures:load
  ```

  When operating in Finland, there is a rake task to populate the postal code and municipality tables with official data provided by Posti:

  ```sh
  rails db:postcodes
  ```

  Optionally you can generate fake person and customer data to help you get started with Folio by testing its features on fake records:

  ```sh
  rails db:populate
  ```

4. Create the first user and unit records

  To be able to log in to Folio, you will need a user record, an associated home unit, and finally grant the user a role in that unit:

  ```ruby
  unit = Unit.create name_fi: 'Yksikön nimi'
  user = unit.users.create email: 'user@localhost', last_name: 'User', first_names: 'Test', activates_at: Date.today, password: 'password'
  user.grant :wizard, unit
  ```


<!-- LICENSE -->
## License

Distributed under the MIT License. See [LICENSE.md][license-url] for more information.



<!-- CONTACT -->
## Contact

Mikko Koivisto - mikko.koivisto@leasit.fi

Project Link: [https://github.com/miakoiv/folio](https://github.com/miakoiv/folio)






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/miakoiv/folio?style=flat-square
[license-url]: https://github.com/miakoiv/folio/blob/master/LICENSE.md
[product-screenshot]: https://leasit.fi/system/images/attachments/000/014/141/lightbox/folio3.JPG
