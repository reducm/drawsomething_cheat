class DrawsController < ApplicationController
  def index
    @draw = Draw.new
    @counter = Counter.visit()
    cookies[:ds] = true 
  end

  def get_answer
    render :json => {f:'f'}.to_json unless cookies[:ds]
    @draw = Draw.new(params[:draw])
    @counter = Counter.visit()
    unless @draw.valid?
      err_str = ''
      @draw.errors.messages.each do |k,v|
        err_str << v.join(',')
        err_str << "\n"
      end
      tmp_map = {:jas_err => err_str, :visit_count => @counter}
      render :json => tmp_map.to_json
      return
    end

    a = params[:draw]
    a = @draw.receive(a[:letters],a[:count])
    if a.length != 0
      a[:visit_count] = @counter
      render :json => a.to_json
    else
      render :json => {'nnull' => 1, :visit_count => @counter }.to_json
    end
  end

end
