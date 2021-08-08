df_raw=read.csv('C:/Users/danny/OneDrive/文档/Python Scripts/covid_across_us/covid.csv',row.names = 1)
library(dplyr)
library(tidyr)
library(ggplot2)
order=df_raw%>%
  arrange(desc(cases))%>%
  mutate(state=factor(state,levels=order$state))

df_raw=df_raw[match(order$state,df_raw$state),]

df<-df_raw%>%
  select(-vaccinationsInitiated)%>%
  gather(key='data',value='value',cases:deaths)%>%
  mutate(state=factor(state,levels=order$state))
total_cases=sum(df_raw['cases'])
title=paste("COVID Data Around USA    Total Confirmed Cases: ",total_cases)
ggplot(df)+
  geom_col(aes(x=state,y=value,fill=data))+
  scale_fill_manual(values=c("#00BFC4", "#F8766D"))+
  geom_line(aes(x=state,y=vaccinationsCompleted),color='#7CAE00',group=1,show.legend = TRUE)+
  scale_color_manual("Fully Vaccinated", values=c(Fully_Vaccinated="#7CAE00"))+
  ggtitle(title)+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab('States')+
  theme_bw()+
  scale_y_continuous(
    
    # Features of the first axis
    name = "Counts",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis( trans=~./331449281*100, name="Percentage %")
  )

    
