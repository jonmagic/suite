class ThingsController < ApplicationController
  before_filter :login_required
  layout nil
  
  def index
    @things = Thing.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @things }
    end
  end

  # GET /things/1
  # GET /things/1.xml
  def show
    @thing = Thing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/new
  # GET /things/new.xml
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = Thing.find(params[:id])
  end

  # POST /things
  # POST /things.xml
  def create
    @thing = Thing.new(params[:thing])
    @thing.attached_id = params[:thing][:attached_id]
    @thing.attached_type = params[:thing][:attached_type]

    respond_to do |format|
      if @thing.save
        flash[:notice] = 'Thing was successfully created.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @thing, :status => :created, :location => @thing }
      else
        format.html { redirect_to :back }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.xml
  def update
    @thing = Thing.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        flash[:notice] = 'Thing was successfully updated.'
        format.html { redirect_to(@thing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.xml
  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to(things_url) }
      format.xml  { head :ok }
    end
  end
end
