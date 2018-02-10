fh = open ('/root/Downloads/davood_python6.csv')
for i in fh.readlines():
    print i
#    select =  raw_input ('Yes Or no? (Y/N) ')
    if int(i.find("user.addNewUsers"))<0:
#    if select=='y':
	print type(i)
        fh2 = open('/root/Downloads/davood_python7.csv', 'a+')
        fh2.write(i)
        fh2.close()   
    else :
        continue
