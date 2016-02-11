BEGIN{
	
}
{
           	  
 
	if ($0 ~ /rlogin/){
		split($0,f1," ")
		bsc = f1[2]
		site = f1[1]
	} else if ($0 ~/ACTIVE/){
                 split($0,lc," ")
                 split(lc[6],ac,":")
                 site_id=ac[1]
        }
        else if ($0 == ""){
		start = "on"
	} else if ($0 ~ "Batch: Error"){
			er=$0;getline; print bsc,"|",er,"|",$0} 


	if (start == "on" && $0 !=  "") {
			if ($0 ~ /FMIC/ || $0 ~ /OIC/ ){
			
				}


			
				


			}
		
				
                                  


                                  # print device_type 
 	
				  printf(" %s|%s|%s|%s|%s|%s|%s|%s |%s\n",bsc,site,site_id,device_type,device_id,alarm_code,tag,date,alarm_string)
   
				
				time_set = "off"
				

			}

			
           	
	}

}
