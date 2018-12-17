rm(list = setdiff(ls(), lsf.str()))
library(pheatmap)
library(data.table)
library(tibble)
library(dplyr)
library(RColorBrewer)
library(dendsort)
library(emdbook)
library(seriation)
a<-fread('matrixphagesalpha0.5newmethodmarinephantome.csv')
b<-at %>%column_to_rownames('name')

bt2<-as.data.frame(t(b))
bt2<-bt2 %>% rownames_to_column('met')
pix<-fread('bp.txt')
colnames(pix)<-c('met','bp','read','avg')
pix2<-pix[,c('met','bp')]
pix2$bp <- pix2$bp/1000000
bt3<-inner_join(bt2,pix2)
bt4<-bt3 %>%column_to_rownames('met')
bt5 <- sweep(bt4[,1:(ncol(bt4)-1)],1,bt4$bp,"/")

bts<-as.data.frame(t(bt5))
bx<-bts
c<-as.matrix(t(bx))
colnames(c)<-rownames(bx)
c<-c[rowSums(c)>0,]
cht<-as.data.frame(c) %>%rownames_to_column('met')
fwrite(as.data.frame(cht),'matrixnormmetalpha0.5newmethodmarinephantome.csv')
