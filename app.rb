#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

get '/admin' do
	erb :admin
end

post '/visit' do

	@user_name  = params[:user_name]
	@phone      = params[:phone]
	@date_time  = params[:date_time]
	@specialist = params[:specialist]

	@title = "Thank you!"
	@message = "Dear #{@user_name}, we'll waiting for you at #{@date_time}!"

	file_users = File.open './public/users.txt', 'a'
	file_users.write "User: #{@user_name},   Phone: #{@phone},   Date and time: #{@date_time},   Specialist: #{@specialist}\n"
	file_users.close

	erb :message
end

post '/contacts' do

	@email        = params[:email]
	@user_message = params[:user_message]

	@title = "Большое спасибо!"
	@message = "<h4>Ваше сообщение очень важно для нас!</h4>
	            <h4>Мы не передаём информацию третьим лицам!</h4>"

	file_contacts = File.open './public/contacts.txt', 'a'
	file_contacts.write "Users_email: #{@email},   Users_message: #{@user_message}\n"
	file_contacts.close

	erb :message
end

post '/admin' do
	@login    = params[:login]
	@password = params[:password]
	@file     = params[:file]

	if @login == 'admin' && @password == 'secret' && @file == 'Посетители'
		@logfile = @file_users
		send_file './public/users.txt'
		erb :create
	elsif @login == 'admin' && @password == 'secret' && @file == 'Контакты'
		@logfile = @file_contacts
		send_file './public/contacts.txt'
		erb :create
	else
		@error ='Access denied'
		erb :admin
	end	
end
