class IntervalsController < ApplicationController
  def index
	@intervals = Interval.all
  end

  def new
	@interval = Interval.new
  end

  def create
	@interval = Interval.new(params[:interval])
	if @interval.save
		flash[:notice] = "Successfuly created new interval."
		redirect_to intervals_path
	else
		render :action => 'new'
	end
  end

  def show
	@interval = Interval.find(params[:id])
  end

end

