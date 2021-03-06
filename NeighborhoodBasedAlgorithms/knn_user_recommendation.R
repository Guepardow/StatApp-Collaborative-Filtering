knn_user_recommendation = function(userID, recap.Users, recap.Movies, data.Ratings, mat.sim, list.dejaVu, K, nb.recommandations, predicteur, nbMin.Ratings){
  #INPUT  userID              : identifiant de l'utilisateur
  #       recap.Users         : base de données et des statistiques des utilisateurs
  #       recap.Movies        : base de données et des statistiques des films
  #       data.Ratings        : base des notes
  #       mat.sim             : matrice de similarité entre les individus
  #       list.dejaVu         : liste des films déjà notés par individu
  #       K                   : nombre de plus proches voisins
  #       nb.recommandations  : nombre de films recommandés
  #       predicteur          : la fonction de prédiction
  #       nbMin.Ratings       : le nombre minimal de visionnage pour qu'un film soit recommandable
  #OUTPUT                     : retourne les recommandations pour l'utilisateur userID
  
  # Plus spécifiquement, cette fonction retourne le vecteur de taille nb.recommandations, contenant les identifiants des films recommandés
  # à partir de l'algorithme des K plus proches (au sens de mat.sim) voisins présents dans recap.Users pour l'individu userID, 
  # calculé à partir (en fonction du prédicteur) des notes de la base data.Ratings. 
  
  # Ensemble des utilisateurs (et donc des potentiels futurs voisins de userID)
  vect.Users = sort(unique(recap.Users$userID))
  
  # Indice de userID dans les matrices 
  userIND = which(vect.Users == userID)
  
  # Filtre des films ayant dépasssé un certain seuil
  vect.Recommandable = sort(unique(recap.Movies$movieID[recap.Movies$nb.Ratings >= nbMin.Ratings]))
  
  # Ensemble des films qui sont susceptibles d'être recommandés à userID
  vect.Recommandable = vect.Recommandable[!(vect.Recommandable %in% list.dejaVu[[userID]])]
  
  # Génération du vecteur vect.Ratings.byNN : vecteur contenant les notes des K plus proches voisins pour un film donné
  vect.Ratings.byNN = as.vector(matrix(NA, nrow = 1, ncol = K))
  
  # Génération du vecteur vect.Prediction : vecteur contenant les prédictions pour tous les films susceptibles d'être recommandés
  vect.Prediction = matrix(NA, nrow = length(vect.Recommandable), ncol = 1)
  
  cat(length(vect.Recommandable))
  
  # Complétion des vecteurs vect.Ratings.byNN et vect.Prediction
  for(movieIND in 1:length(vect.Recommandable)){
    cat(sprintf("|%0.f",movieIND))
    
    movieID = vect.Recommandable[movieIND]
    knn = K_nearest_neighbors(userID, movieID, K, list.dejaVu, vect.Users, mat.sim)
    
    #vecteur contenant les notes des K plus proches voisins pour un film donné
    for(k in 1:K){
      if(!is.na(knn[k,1])){
        vect.Ratings.byNN[k] = data.Ratings$rating[(data.Ratings$userID == knn[k,1]) & (data.Ratings$movieID == movieID)]
      }
    }
 
    vect.Prediction[movieIND] =  knn_user_predicteur(knn$similarities, vect.Ratings.byNN, recap.Users, userID, predicteur, knn$neighbors)
  }
  
  mat.RecommendedMovies = as.data.frame(matrix(NA, nrow = nb.recommandations, ncol = 2))
  colnames(mat.RecommendedMovies) = c("movieID", "prating")
  for(movieIND in 1:nb.recommandations){
    mat.RecommendedMovies$movieID[movieIND] = vect.Recommandable[order(vect.Prediction, decreasing = TRUE)][movieIND]
    mat.RecommendedMovies$prating[movieIND] = vect.Prediction[order(vect.Prediction, decreasing = TRUE)[movieIND]]
  }
  
  return(mat.RecommendedMovies)
}
