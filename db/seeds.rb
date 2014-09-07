# coding: utf-8

user = User.create(email:'user@fontaineolivres.com',password:'fontaine')
user.add_role :admin if user # sets a global role
user.save