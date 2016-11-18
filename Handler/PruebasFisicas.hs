module Handler.PruebasFisicas where

import Import
import Data.Time

postPruebasFisicasR :: Handler Value
postPruebasFisicasR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    tipoUsuario <- (requireJsonBody :: Handler PruebasFisicas)
    today <- liftIO $ (utctDay <$> getCurrentTime)
    let pruebasFisicaInsert = tipoUsuario {pruebasFisicasFechaPrueba = Just today}
    insertedComment <- runDB $ insertEntity pruebasFisicaInsert
    returnJson insertedComment

getPruebasFisicasR :: Handler Value
getPruebasFisicasR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([] :: [Filter PruebasFisicas]) []
    returnJson maybePerson

putPruebasFisicas2R :: PruebasFisicasId -> Handler Value
putPruebasFisicas2R id = do
    pruebasFisicas <- (requireJsonBody :: Handler PruebasFisicas)    
    pruebasUpdated <- runDB $ updateGet id [PruebasFisicasPeso =. (pruebasFisicasPeso pruebasFisicas), PruebasFisicasEstatura =. (pruebasFisicasEstatura pruebasFisicas), PruebasFisicasTensionArterial =. (pruebasFisicasTensionArterial pruebasFisicas), PruebasFisicasFrecuenciaCardiaca1 =. (pruebasFisicasFrecuenciaCardiaca1 pruebasFisicas), PruebasFisicasFrecuenciaCardiaca2 =. (pruebasFisicasFrecuenciaCardiaca2 pruebasFisicas), PruebasFisicasFrecuenciaCardiaca3 =. (pruebasFisicasFrecuenciaCardiaca3 pruebasFisicas), PruebasFisicasWells =. (pruebasFisicasWells pruebasFisicas), PruebasFisicasAbdominales =. (pruebasFisicasAbdominales pruebasFisicas), PruebasFisicasFuerzaBrazos =. (pruebasFisicasFuerzaBrazos pruebasFisicas), PruebasFisicasFuerzaPierna =. (pruebasFisicasFuerzaPierna pruebasFisicas), PruebasFisicasObservaciones =. (pruebasFisicasObservaciones pruebasFisicas)]
    returnJson pruebasUpdated

deletePruebasFisicas3R :: PruebasFisicasId -> Handler String
deletePruebasFisicas3R id = do
    runDB $ deleteWhere [PruebasFisicasId ==. id]
    return "Ok"

getPruebasFisicas1R :: UsuarioId -> Handler Value
getPruebasFisicas1R id = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([PruebasFisicasIdUsuario ==. id]) [LimitTo 1]

    returnJson maybePerson  
