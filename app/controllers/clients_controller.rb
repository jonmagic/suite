class ClientsController < ApplicationController
  before_filter :login_required
  layout 'clients'
  
  def index
    @clients = []
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
      format.json  { render :json => @clients }
    end
  end
  
  def search
    if !params[:q].blank?
      params[:q] = params[:q].gsub(/517/, "")
      @clients = Client.search(params[:q], :limit => 100, :include => [:phones])
    else
      @clients = []
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @clients }
      format.json  { render :json => @clients }
    end
  end
  
  def show
    @phone_count, @email_count, @address_count = 0
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @client }
      format.json  { render :json => @client }
    end
  end
  
  def new
    @client = Client.new
    @client.phones.build
    @client.emails.build
    @client.addresses.build
  end
  
  def edit
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @client }
      format.json  { render :json => @client }
    end
  end
  
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    params[:client][:existing_phone_attributes] ||= {}
    params[:client][:existing_email_attributes] ||= {}
    params[:client][:existing_address_attributes] ||= {}
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes params[:client]
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        flash[:notice] = @client.errors.inspect       
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end

end
