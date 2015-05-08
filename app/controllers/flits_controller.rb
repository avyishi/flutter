class FlitsController < ApplicationController
 

  def create
  @flit = current_user.flits.build(flit_params)
    if @flit.save
      flash[:success] = "Flit created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def new
    @flit = Flit.new
  end

  def destroy
  end

  def index
    @flit = Flit.all
  end

  def show
    @flit = Flit.find(params[:id])
  end

  private

    def flit_params
      params.require(:flit).permit(:content)
    end
end
