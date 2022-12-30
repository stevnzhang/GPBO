# Great Pittsburgh Baking Outlet

## Table of Contents

- [Overview](#overview)
- [Features](#features)
  - [Admin](#admin)
  - [Customer](#customer)
  - [Misc](#misc)
- [Testing](#testing)
- [How to run GPBO](#how-to-run-gpbo)
- [Learning Goals](#learning-goals)
- [Author's Note](#authors-note)

## Overview

GPBO was ~10 week long project that was aimed at building a website from virtually the ground up. Complete with admin, shipper, and customer roles -- each with their respective views and functions, as well as a comprehensive testing suite for the models, controllers, and views. 

## Features

### Admin
- Items
  - Add items
  - List items
  - View item details
  - Edit item details
  - Archive items
  - Search + filter items
- Users
  - List users (customers, shippers, admins)
  - View users (customers, shippers, admins)
  - View a user's order history

### Customer
- Account
  - Create account
  - View account details
  - Edit account details
- Items
  - List items
  - View item details
  - Search + filter items
- Cart
  - Add items to cart
  - Remove items from cart
  - Checkout cart
- Order
  - List previous orders
  - View previous order details


### Misc
- Flash messages
- Form validations (Address, phone, credit card, etc.)

## Testing
Achieved 100% code coverage using unit tests for the models, controllers, and views.

Run `rails test` to run the testing suite

## How to run GPBO

Install Ruby 2.6.9 from [here](https://rubyinstaller.org/downloads/archives/).

Then, navigate to the GPBO directory and run the following commands:\
`bundle install`\
`rails db:migrate`\
`rails server`

## Learning Goals

- Understand how to model data and translate those data models into working
databases
- Become familiar with Model-View-Controller pattern in software architecture
- Understand why and how to do software testing
- Learn how to use source code control to manage project development
- Know and apply principles of user-centered design to the development of software

## Author's Note

WIP!
