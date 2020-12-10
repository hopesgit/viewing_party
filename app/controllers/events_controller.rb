class EventsController < ApplicationController
  def new
    # binding.pry
    @movie = Movie.create(movie_params)
    @event = Event.new
  end

  def create
    # require 'pry'; binding.pry
    @movie = Movie.last
    @event = Event.new(final_params)
    if @event.save
      add_participants(@event.id)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def movie_params
    params.permit(:api_id, :runtime, :title)
  end

  def event_params
    params.require(:event).permit(:user_id, :movie_id, :start_time, :duration)
  end

  def date_result
    date = event_params.values[0..2].join('-')
    time = event_params.values[3..4].join(':')
    res = date + ' ' + time
    res.to_datetime
  end

  def final_params
    { user_id: current_user.id, movie_id: @movie.id, start_time: date_result, duration: event_params[:duration] }
  end

  def add_participants(event_id)
    params[:friend_id].each do |friend|
      user = User.find(friend)
      Participant.create(user_id: user.id, event_id: event_id)
    end
  end
end
