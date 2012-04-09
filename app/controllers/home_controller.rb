class HomeController < ApplicationController
  def index
  	 @title = "Test application Graph"
         location_id = params[:location]
         days = params[:days]
         #render :text => days and return
         case days
			when "Week"
			  limit_rec = 7
			  #render :text => limit_rec and return
			when "Month"
			  limit_rec = 30
			when "3_Months"
			   limit_rec = 90
			when "Year"
				limit_rec = 365   	  
			else
			  limit_rec = 7
			end
#render  :text => limit_rec and return
         if location_id.nil? || location_id == "Show_all_location "                     	
         	@first_seventh = Receipt.all(:select => "date, sum(q_1) as q_1, sum(q_2) as q_2, sum(q_3) as q_3, sum(avg) as avg",:group => "date", :limit => "#{limit_rec}", :order => "date desc")       	
         	@multi = 1 # This is to hide the text in x-axis as it becomes messed   		
         else  			
  			@first_seventh = Receipt.all(:select => "date, sum(q_1) as q_1, sum(q_2) as q_2, sum(q_3) as q_3, sum(avg) as avg",:conditions => ["location_id = ?", location_id],:group => "date", :limit => "#{limit_rec}", :order => "date desc")
  			@multi = 0  
  		 end  	 		 	 
	  	dates = []
	  	q1 = []
		    q2 = []
		    q3 = []
		    avg = []       
  	@first_seventh.each do |f_s|              
               if limit_rec == 30 || limit_rec == 90 || limit_rec == 365 
               	dates << f_s.date.to_date().day
               	@multi = 1
               else
               	dates << f_s.date
               end  		                
  		q1 << f_s.q_1
  		q2 << f_s.q_2
  		q3 << f_s.q_3
#               agg_ans = f_s.q_1.to_i+f_s.q_2.to_i+f_s.q_3.to_i
#               agg_ans_float = agg_ans.to_f/3
#                avg << agg_ans_float
avg << f_s.avg
  	end  	
  	#render :text => q1.to_s+"-"+q2.to_s+"-"+q3.to_s+"-"+avg.to_s and return
        #render :text => dates and return  
  	j = ActiveSupport::JSON  	
  	@dates_json = j.encode(dates).gsub("\"","'")
  	@q1 = j.encode(q1)
  	@q2 = j.encode(q2)
  	@q3 = j.encode(q3)
        @avg = j.encode(avg).gsub("\"","")
        respond_to do |format|
        format.html
        format.js
       end
  end

  def processing
  	   # TODO work with delayed job
      begin
         	  require 'rubygems'
         	  require 'roo'
         	  oo = Excelx.new("http://dl.dropbox.com/u/71317935/recordlist.xlsx")          
         	  oo.default_sheet = oo.sheets.second		  
         	  2.upto(oo.last_row) do |line|
         	   id = oo.cell(line, 'A')
           	   date = oo.cell(line,'B')	  	   
           	   location = oo.cell(line,'D')
           	   avg = oo.cell(line,'E')
           	   q_1 = oo.cell(line,'F')
         	   q_2 = oo.cell(line,'G')
         	   q_3 = oo.cell(line,'H')  
         	   approved = oo.cell(line, 'I')		    		  
           	   if date
           		   receipt = Receipt.new
           		   receipt.update_attributes(:receipt_id => id.to_i, :date => date.to_s, :location_id => location.to_i, :avg => avg.to_f, :q_1 => q_1.to_i, :q_2 => q_2, :q_3 => q_3, :approved => approved.to_s)
           		end
           	  end	
       rescue => e
        render :text => e and return
       end
  end

end
