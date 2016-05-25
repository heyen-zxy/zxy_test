# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create({login: 'admin', email: '645054538@qq.com', password: '12345678', password_confirmation: '12345678'})
Admin.create({login: 'normal', email: '6450545381@qq.com', password: '12345678', password_confirmation: '12345678'})
Admin.create({login: 'user', email: '6450545382@qq.com', password: '12345678', password_confirmation: '12345678'})