# Dealing with missing values:
MissingValues <- function(matrix, NAs, Save.MatImp, IP, ParModel, Ability, Method, mu, sigma)
{
  N <- dim(matrix)[1]; I <- dim(matrix)[2]
  if (sum(is.na(matrix)) > 0)
  {
    lst <- switch(
      NAs,
      Hotdeck = HD.imputation(matrix, Save.MatImp, IP, Ability),
      NPModel = NPModel.imputation(matrix, Save.MatImp, IP, Ability),
      PModel  = {
        # Sanity check - IP model:
        Sanity.IPm(ParModel)
        # Sanity check - Ability method:
        Sanity.Abm(Method)
        # 
        PModel.imputation(matrix, Save.MatImp, 
                                      IP, ParModel, Ability, Method, mu, sigma)
      }
    )
  } else
  {
    lst <- list(matrix, IP, Ability, 0)
  }
  lst
}

# Dealing with missing values (polytomous):
MissingValues.poly <- function(matrix, Ncat, NAs, Save.MatImp, IP, ParModel, Ability, Method)
{
  N <- dim(matrix)[1]; I <- dim(matrix)[2]
  if (sum(is.na(matrix)) > 0)
  {
    lst <- switch(
      NAs,
      Hotdeck = HD.imputation(matrix, Save.MatImp, IP, Ability),
      NPModel = NPModel.imputation.poly(matrix, Ncat, Save.MatImp, IP, Ability),
      PModel  = {
        PModel.imputation.poly(matrix, Ncat, Save.MatImp,IP, ParModel, Ability, Method)
      }
    )
  } else
  {
    lst <- list(matrix, IP, Ability, 0)
  }
  lst
}