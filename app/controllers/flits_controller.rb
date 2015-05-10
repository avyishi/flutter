class FlitsController < ApplicationController
  def index
    @flit = Flit.all
  end

  def show
    @flit = Flit.find(params[:id])
  end

  def new
    @flit = Flit.new
  end

  def create
    @flit = Flit.new(flit_params)
    @flit.user = current_user
      if @flit.save
        redirect_to flits_path
      else
        render 'static_pages/home'
      end
  end

  def destroy
    @flit = Flit.find(params[:id])

    if @flit.destroy
       redirect_to @flit
     else
       render root_url
     end
  end

  private

  def flit_params
    params.require(:flit).permit(:content)
  end
end
