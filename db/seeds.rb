# coding: utf-8

User.create!( name: "Sample User",
    					email: "sample@email.com",
    					password: "password",
    					password_confirmation: "password",
    					admin: true)

User.create!( name: "岸田A",
    					email: "sample-1@email.com",
    					password: "password",
    					password_confirmation: "password",
    					department: "group1",
              superior: true)

User.create!( name: "岸田B",
    					email: "sample-2@email.com",
    					password: "password",
    					password_confirmation: "password",
    					department: "group1",
              superior: true)

User.create!( name: "安倍A",
              email: "sample-3@email.com",
              password: "password",
              password_confirmation: "password",
              department: "group2",
              superior: true)             
                
User.create!( name: "安倍B",
              email: "sample-4@email.com",
              password: "password",
              password_confirmation: "password",
              department: "group2",
              superior: true)                   