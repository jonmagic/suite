class ChecklistsController < ApplicationController
  before_filter :login_required
  layout nil
  
  def edit
    @checklist = Checklist.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checklist }
      format.json  { render :json => @checklist }
    end
  end
  
  def update
    params[:checklist][:existing_checklist_item_attributes] ||= {}
    
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      if @checklist.update_attributes params[:checklist]
        flash[:notice] = 'Checklist was successfully updated.'
        format.html { redirect_to :back }
        format.xml  { head :ok }
      else
        flash[:notice] = @checklist.errors
        format.html { redirect_to :back }
        format.xml  { render :xml => @checklist.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    @checklist = Checklist.new(params[:checklist])
    @checklist.name = @checklist.checklist_template.name
    if params[:ticket_id] != nil
      @ticket = Ticket.find(params[:ticket_id])
      @checklist.ticket = @ticket
    end
    
    respond_to do |format|
      if @checklist.save
        if params[:ticket_id] != nil
          TicketEntry.create(:entry_type => "Added Checklist", :note => "Checklist (#{@checklist.name}) was added to this ticket.", :billable => false, :private => true, :detail => 6, :ticket => @checklist.ticket, :creator_id => current_user.id)
        end
        flash[:notice] = 'Checklist successfully created.'
        format.html { redirect_to :back }
      else
        flash[:notice] = 'Checklist could not be created.'
        format.html { redirect_to :back }
      end
    end
  end
  
  def remove_from_ticket
    @checklist = Checklist.find(params[:id])
    TicketEntry.create(:entry_type => "Removed Checklist", :note => "Checklist (#{@checklist.name}) was removed from this ticket.", :billable => false, :private => true, :detail => 6, :ticket => @checklist.ticket, :creator_id => current_user.id)
    @checklist.destroy
    redirect_to :back
  end
  
end