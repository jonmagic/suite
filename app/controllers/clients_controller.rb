class ClientsController < ApplicationController
  before_filter :login_required
  
  def index
    options = {
      # :order => 'name DESC'
      # :page => params[:page]
    }
    if params[:term]
      options[:conditions] = [
        "name LIKE :term OR lastname LIKE :term OR firstname LIKE :term",
        {:term => "%#{params[:term]}%"}
        ]
    end
    @clients = Client.find(:all, options)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end
  
  def show
    @phone_count, @email_count, @address_count = 0
    @client = Client.find(params[:id])
    @client_notes = RedCloth.new(@client.note)
  end
  
  def new
    @client = Client.new
    @companies = Client.find(:all, :conditions => {:company => true})
    @client.phones.build
    @client.emails.build
    @client.addresses.build
  end
  
  def edit
    @client = Client.find(params[:id])
    @companies = Client.find(:all, :conditions => {:company => true})
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
