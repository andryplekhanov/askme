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
      avatar_url: 'https://pp.userapi.com/c836226/v836226315/12713/1Ko1J3P2j6E.jpg'
    )
  end
end
