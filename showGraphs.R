df=read.csv('C:/Users/danny/OneDrive/??????/Python Scripts/covid_across_us/covid.csv',row.names = 1)
library(dplyr)
df=df%>%
  arrange(desc(cases))
df$state=factor(df$state,levels=df$state)
df$group_by_cases[1:nrow(df)]=0
groupSize=ceiling(nrow(df)/3)
df[1:groupSize,'group_by_cases']='High'
df[(groupSize+1):(2*groupSize),'group_by_cases']="Middle"
df[(groupSize*2+1):nrow(df),'group_by_cases']="Low"
df$group_by_cases=factor(df$group_by_cases,levels=c('High','Middle','Low'))
library(ggplot2)
library(ggthemes)
total_cases=sum(df['cases'])
title=paste("COVID Data Around USA    Total Confirmed Cases: ",total_cases)
ggplot(df)+
  geom_col(aes(x=state,y=cases,fill=group_by_cases))+
  geom_col(aes(x=state,y=deaths),fill='violetred4')+
  scale_fill_manual('Confirmed Cases',values=c('blue4','blue3','blue2'))+
  geom_line(aes(x=state,y=vaccinationsCompleted),group=1,color='springgreen1',show.legend = TRUE)+
  ggtitle(title)+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab('States')+
  ylab('Counts')+
  ylim(c(0,20961749))+
  scale_color_manual("Fully Vaccinated", values=c(green="green"))

