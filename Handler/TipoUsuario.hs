module Handler.TipoUsuario where

import Import

postTipoUsuarioR :: Handler Value
postTipoUsuarioR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    tipoUsuario <- (requireJsonBody :: Handler TipoUsuario)

    insertedComment <- runDB $ insertEntity tipoUsuario
    returnJson insertedComment

getTipoUsuarioR :: Handler Value
getTipoUsuarioR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([] :: [Filter TipoUsuario]) []

    returnJson maybePerson

getTipoUsuario1R :: TipoUsuarioId -> Handler Value
getTipoUsuario1R id = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([TipoUsuarioId ==. id]) [LimitTo 1]

    returnJson maybePerson  
