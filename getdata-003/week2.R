# library(httr)
# oauth_endpoints("github")
# myapp <- oauth_app(appname="getdata-003", 
#                    key="ad1d4dff698ae539273d",
#                    secret="f9efa14f03afd5f8329110b427599f3531d4230d")
# github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
# json1 = content(data)
# json2 = jsonlite::fromJSON(toJSON(json1))

# library(sqldf)
# download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
#              destfile="week2.csv"
#              method="curl")
# acs <- read.csv("week2.csv")
# sqldf("select pwgtp1 from acs where AGEP < 50")
# sqldf("select distinct AGEP from acs")

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
print(nchar(htmlCode[10]))
print(nchar(htmlCode[20]))
print(nchar(htmlCode[30]))
print(nchar(htmlCode[100]))

library(foreign)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
             destfile="week2.for",
             method="curl")
data <- read.fwf(file="week2.for",
                 widths=c(15,4,9,4,9,4,9,4,4),
                 col.names=FALSE,
                 skip=4)
print(sum(data$V4))
