class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Andrey',
      username: 'andrey_plekhanov',
      # avatar_url: 'https://pp.userapi.com/c836226/v836226315/12713/1Ko1J3P2j6E.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('20.03.2000')),
      Question.new(text: 'Что нового?', created_at: Date.parse('20.03.2000'))
    ]
  end
end
