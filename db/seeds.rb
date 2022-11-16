# coding: utf-8

User.create!( name: "Admin User",
    					email: "admin@email.com",
    					password: "password",
    					password_confirmation: "password",
              department: "group_number1",
    					admin: true)

User.create!( name: "サンプル太郎",
    					email: "sample-1@email.com",
    					password: "password",
    					password_confirmation: "password",
    					department: "group_number1",
              partner: true)

User.create!( name: "サンプル姫子",
    					email: "sample-2@email.com",
    					password: "password",
    					password_confirmation: "password",
    					department: "group_number1",
              partner: true)

User.create!( name: "テスト太郎",
              email: "sample-3@email.com",
              password: "password",
              password_confirmation: "password",
              department: "group_number2",
              partner: true)             
                
User.create!( name: "テスト姫子",
              email: "sample-4@email.com",
              password: "password",
              password_confirmation: "password",
              department: "group_number2",
              partner: true)                   