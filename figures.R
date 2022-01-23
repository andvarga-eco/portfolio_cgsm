library(readr)
library(imputeTS)
library(ggplot2)
library(ggpubr)

#Load data

plots<-read_csv("C:/Users/andre/Google Drive/Uninorte/AE-CGSM-Redes/data/biofísica/pesca/Analisis en R/Pesca/plots.csv")
pesca<-read_csv("C:/Users/andre/Google Drive/Uninorte/AE-CGSM-Redes/data/biofísica/pesca/Analisis en R/Pesca/fig3.csv")


#Figure 2.

sline<-ggplot(plots,aes(x=fecha))+geom_line(aes(y=salimp),color="black",size=1)+
  theme_minimal()+xlab("")+ylab("Sal. (g/kg)")+
  annotate("rect", xmin=as.Date("2014-09-01"), xmax =as.Date("2016-05-01"), ymin = 0, ymax = 45, alpha = .5,fill="red")+
  annotate("rect", xmin=as.Date("2009-06-01"), xmax =as.Date("2010-04-01"), ymin = 0, ymax = 45, alpha = .5,fill="red")+
  annotate("rect", xmin=as.Date("2004-06-01"), xmax =as.Date("2005-03-01"), ymin = 0, ymax = 45, alpha = .5,fill="red")+
  annotate("rect", xmin=as.Date("2002-05-01"), xmax =as.Date("2003-03-01"), ymin = 0, ymax = 45, alpha = .5,fill="red")+
  annotate("rect", xmin=as.Date("2005-10-01"), xmax =as.Date("2006-04-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")+
  annotate("rect", xmin=as.Date("2007-05-01"), xmax =as.Date("2008-07-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")+
  annotate("rect", xmin=as.Date("2008-10-01"), xmax =as.Date("2009-04-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")+
  annotate("rect", xmin=as.Date("2010-05-01"), xmax =as.Date("2012-05-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")+
  annotate("rect", xmin=as.Date("2016-06-01"), xmax =as.Date("2017-01-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")+
  annotate("rect", xmin=as.Date("2017-09-01"), xmax =as.Date("2018-05-01"), ymin = 0, ymax = 45, alpha = .5,fill="#00AFBB")

smes<-plots%>%group_by(mes1)%>%summarise(smes=mean(salimp))%>%mutate(mes1=fct_relevel(mes1,
                                                                                           "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"))%>%ggplot(aes(x=mes1,y=smes))+geom_col()+
  xlab("")+ylab("Average salinity (g/kg)")+theme_minimal()+labs(title="Average salinity by month")

fig2<-ggarrange(sline,smes,nrow=2)
fig2

# Figure 3

fig3<-pesca%>%filter(!is.na(salinidad))%>%ggplot(aes(x=rsallab,y=capturakg,fill=name))+geom_bar(position="fill",stat="identity")+ylab("Proportion")+
  theme_minimal()+theme(legend.title=element_blank(),legend.position="right")+xlab("Salinity levels (g/kg)")+
  scale_x_discrete(limits=c("0-5", "6-18", "19-30",">30"))+scale_fill_brewer(palette="Dark2",direction=-1)
fig3


# Figure 4

zbox<-ggplot(plots,aes(x=rsallab,y=z,fill=rsallab))+geom_boxplot()+ylim(10,65)+
  theme_minimal()+scale_fill_manual(values = c("#00AFBB","#00AFBB","#00AFBB","#00AFBB"))+ scale_x_discrete(limits=c("0-5", "6-18", "19-30",">30"))+
  xlab("Salinity levels")+ylab("CPUE (kg)")+theme(legend.position = "none")    

ybox<-ggplot(plots,aes(x=rsallab,y=ermy,fill=rsallab))+geom_boxplot()+ylim(8,36)+
  theme_minimal()+scale_fill_manual(values=c("#E7B800","#E7B800","#E7B800","#E7B800"))+ scale_x_discrete(limits=c("0-5", "6-18", "19-30",">30"))+
  xlab("Salinity levels")+ylab("YPUE (COP thousand)")+theme(legend.position = "none")    


yline<-ggplot(plots,aes(x=fecha))+geom_line(aes(y=ermyimp),color="#E7B800",size=1)+
  theme_minimal()+xlab("")+ylab("YPUE (COP)")
zline<-ggplot(plots,aes(x=fecha))+geom_line(aes(y=zimp),color="#00AFBB",size=1)+
  theme_minimal()+xlab("")+ylab("CPUE (kg)")

fig4<-ggarrange(zbox,ybox,zline,yline,ncol=2,nrow=2)
fig4

