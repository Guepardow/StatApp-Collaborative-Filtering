function(stat_Users,stat_Movies, matrixTest){  #userID,movieID){
  
  #X=stat_Users$rating[(stat_Users$userID==userID)&(stat_Users$movieID==movieID)]
  #if (length(X)>0){
  #  cat("L'utilisateur", userID, " a déja  noté le film",movieID,"il lui a donné la note de",x1,x2,x3,x4)
  #}
  #else{
    D =(dim(matrixTest)[1])
    matrixTest$Prediction1=runif(D,1,5)
    
    #par la note moyenne de USER
    matrixTest$Prediction2=mean(stat_Users$mean,na.rm=T)
    
    matrixTest$Prediction3=mean(stat_Movies$mean,na.rm=T) # on doit d'abord enlever les films qui n'ont pas été noté ie qui ont une moyenne = a Nan avant de prendre la moyenne generale
    
    for (couple in 1:(dim(matrixTest)[1])) { 
      matrixTest$Prediction4[couple]=stat_Users$mean[stat_Users$userID==matrixTest$userID[couple]]
    }
    
    for (couple in 1:(dim(matrixTest)[1])) { 
      matrixTest$Prediction5[couple]=stat_Movies$mean[stat_Movies$movieID==matrixTest$movieID[couple]]
    }
    
    #matrixTest$Prediction4=stat_Users$mean[stat_Users$userID==matrixTest$userID]
    
    #pred[5]=stat_Movies$mean[stat_Movies$movieID==movieID]
    
    #pred=round(pred,4)
    
    return(pred)
  #}
}
