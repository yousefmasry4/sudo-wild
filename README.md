# sudo-wild


## first thing first,
the API server has been written using Python by a framework called "flask", on the other side, the app was written in dart lang by flutter framework and this means that it can work in all platforms.

## second thing second,
this program has three features, the first one is the computer vision to recognize the animal name and it uses some reference by web scraping to tell us the status of the animal is illegal to own or hunt or not, is dangerous or not and so on and then it tells you some information about this animal i.e. Taxonomy, origin, Lifespan and biology, in this feature I have  used "haar cascade " to classification and "vp-tree" to hashing, second feature is report page, is a simple page in my app to make anyone able to report about any illegal problem and he/she can attach photo or screen shoot in report, in this part I have used "MongoDB" to save all reports,last feature is QR code,In this section, the program assists customs workers, in particular, to encode animals image to QR code to help them to avoid the replacing or other illegal works, by making the recipient Customs to decode QR to get the photo and compare between them
