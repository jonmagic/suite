class ChecklistTemplatesController < ApplicationController
  before_filter :login_required
  layout 'settings'
  
  def index
    @checklists = ChecklistTemplate.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checklists }
      format.json  { render :json => @checklists }
    end
  end
  
  def show
    @checklist = ChecklistTemplate.find(params[:id])
    @device_types = DeviceType.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checklist }
      format.json  { render :json => @checklist }
    end
  end
  
  def add_assocation
    @checklist = ChecklistTemplate.find(params[:checklist_template_id])
    @associate = DeviceType.find(params[:id])
    @checklist.device_types << @associate
    redirect_to(@checklist)
  end
  
  def remove_assocation
    @checklist = ChecklistTemplate.find(params[:checklist_template_id])
    @associate = DeviceType.find(params[:id])
    @checklist.device_types.delete(@associate)
    redirect_to(@checklist)
  end  
  
  def new
    @checklist = ChecklistTemplate.new
    @checklist.checklist_template_questions.build
  end
  
  def edit
    @checklist = ChecklistTemplate.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checklist }
      format.json  { render :json => @checklist }
    end
  end
  
  def create
    @checklist = ChecklistTemplate.new(params[:checklist_template])

    respond_to do |format|
      if @checklist.save
        flash[:notice] = 'Checklist was successfully created.'
        format.html { redirect_to(@checklist) }
        format.xml  { render :xml => @checklist, :status => :created, :location => @checklist }
      else
        flash[:notice] = @checklist.errors.inspect
        format.html { render :action => "new" }
        format.xml  { render :xml => @checklist.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    params[:checklist_template][:existing_checklist_template_question_attributes] ||= {}
    
    @checklist = ChecklistTemplate.find(params[:id])

    respond_to do |format|
      if @checklist.update_attributes params[:checklist_template]
        flash[:notice] = 'Checklist was successfully updated.'
        format.html { redirect_to(@checklist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checklist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @checklist = ChecklistTemplate.find(params[:id])
    @checklist.destroy

    respond_to do |format|
      format.html { redirect_to(checklists_url) }
      format.xml  { head :ok }
    end
  end

end
