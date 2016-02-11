
userhome = '/'
list = []
minilist = []
minilist2 = []
minilist3=[]
minilist4=[]
time1=0
time2=0
sec=0
minute=0
#import fileinput

import sys
for line in sys.stdin:
	line = line.strip()
	list = line.split('|')

	minilist = list[1].split(' ')
	minilist2 = minilist[1].split(':')
	date1 = minilist2[0]

	
	minilist3 = list[2].split(' ')
	minilist4 = minilist3[1].split(':')


	if(len(minilist)==3):
		if(minilist[2]=='PM'):
			if(minilist2[0]!='12'):
				time1 = (int)(minilist2[0])+12
			else:
				time1 = (int)(minilist2[0])
		else:
			time1 = (int)(minilist2[0])

	else:
		time1 = (int)(minilist2[0])
	

	if(len(minilist3)==3):
		if(minilist3[2]=='PM'):
			if(minilist4[0]!='12'):
				time2 = (int)(minilist4[0])+12
			else:
				time2 = (int)(minilist4[0])
		else:
			time2 = (int)(minilist4[0])

	else:
		time2 = (int)(minilist4[0])
	
	

	sec = int(minilist2[2])
	minute = int(minilist2[1])
	sec2 = int(minilist4[2])
	minute2 = int(minilist4[1])
	

	if(time1!=time2):

		
		sec = (60-sec)/60.0
	#	sec = sec/60.0
		minute = 59-minute
		minute = minute+sec
		if(minute<10):
			minute = "%.2f" % minute
			minute = '0'+minute
			
		else:
			minute = "%.2f" % minute


		sec2 = sec2/60.0
		minute2 = minute2+sec2
		if(minute2<10):
			minute2 = "%.2f" % minute2
			minute2 = '0'+minute2

		else:
			minute2 = "%.2f" % minute2

		y = str(time1).zfill(2)

		print list[0]+'|'+minilist[0]+'|'+y+'|'+str(minute)+'|'+list[3]

		for x in range (time1+1,time2):
			if(x<10):
				x=str(x).zfill(2)
	
	
			print list[0]+'|'+str(minilist[0])+'|'+str(x)+'|'+'60'+'.00'+'|'+list[3]



		y = str(time2).zfill(2)
	

		print list[0]+'|'+minilist3[0]+'|'+y+'|'+str(minute2)+'|'+list[3]


	else:

		
		if(minute==minute2):
			fsec=sec2-sec
			fmin=0
			

		elif(sec>sec2):
			
			fmin=minute2-minute-1
			fsec=59-sec-sec2
			

		else:
			fmin=minute2-minute
			fsec=sec2-sec
			
		fsec= fsec/60.0
		
		fmin = fmin+fsec

		if(fmin<10):
			fmin = "%.2f" % fmin
			fmin = '0'+fmin

		else:
			fmin = "%.2f" % fmin
	
		y = str(time2).zfill(2)

		print list[0]+'|'+minilist3[0]+'|'+y+'|'+str(fmin)+'|'+list[3]
