library(tm)
library(stringi)
library(wordcloud)

all_msgs<-readLines("MCS.txt", encoding="UTF-8" )
all_msgs<-iconv(all_msgs, "latin1", "ASCII", sub="")
all_msgs_cloud<-Corpus(VectorSource(all_msgs))
all_msgs_cloud <- tm_map(all_msgs_cloud, tolower)
all_msgs_cloud<- tm_map(all_msgs_cloud, removeNumbers)
all_msgs_cloud <- tm_map(all_msgs_cloud, removePunctuation)

dtm<-DocumentTermMatrix(finalall_msgs_cloud)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)
frequency<-as.data.frame(frequency)

####create the unigram in dataframe format with two columns
terms<-row.names(frequency)
fDF1<-data.frame(terms=terms, freq=frequency)

###bigrams
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))  
tdm.ng <- TermDocumentMatrix(finalall_msgs_cloud, control = list(tokenize = BigramTokenizer))
dtm.ng <- DocumentTermMatrix(finalall_msgs_cloud, control = list(tokenize = BigramTokenizer))

m = as.matrix(tdm.ng)
v = sort(rowSums(m),decreasing=TRUE)
fDF2= data.frame(terms = names(v),freq=v)



###trigrams
trigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))  
tdm.ng <- TermDocumentMatrix(finalall_msgs_cloud, control = list(tokenize = trigramTokenizer))
dtm.ng <- DocumentTermMatrix(finalall_msgs_cloud, control = list(tokenize = trigramTokenizer))

m = as.matrix(tdm.ng)
v = sort(rowSums(m),decreasing=TRUE)
fDF3= data.frame(terms = names(v),freq=v)


###fourgrams
trigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))  
tdm.ng <- TermDocumentMatrix(finalall_msgs_cloud, control = list(tokenize = trigramTokenizer))
dtm.ng <- DocumentTermMatrix(finalall_msgs_cloud, control = list(tokenize = trigramTokenizer))

m = as.matrix(tdm.ng)
v = sort(rowSums(m),decreasing=TRUE)
fDF4= data.frame(terms = names(v),freq=v)



save(fDF1, file="fDF1.RData");
save(fDF2, file="fDF2.RData");
save(fDF3, file="fDF3.RData");
save(fDF4, file="fDF4.RData");


###deployApp(appName = "VFIT_MCS_NextWordPrediction")