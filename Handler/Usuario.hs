module Handler.Usuario where

import Import
import Data.Time

postUsuarioR :: Handler Value
postUsuarioR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    usuario <- (requireJsonBody :: Handler Usuario)    
    today <- liftIO $ (utctDay <$> getCurrentTime)
    let usuarioInsert = usuario {usuarioFechaNacimiento = Just today}

    insertedComment <- runDB $ insertEntity usuario
    returnJson insertedComment

getUsuarioR :: Handler Value
getUsuarioR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([] :: [Filter Usuario]) []

    returnJson maybePerson

putUsuario2R :: UsuarioId -> Handler Value
putUsuario2R  id = do
    usuario <- (requireJsonBody :: Handler Usuario)    
    usuarioUpdated <- runDB $ updateGet id [UsuarioNombre =. (usuarioNombre usuario), UsuarioGenero =. (usuarioGenero usuario), UsuarioTipoUsuario =. (usuarioTipoUsuario usuario), UsuarioFechaNacimiento =. (usuarioFechaNacimiento usuario), UsuarioIdentificacion =. (usuarioIdentificacion usuario), UsuarioTelefono =. (usuarioTelefono usuario), UsuarioEmail =. (usuarioEmail usuario), UsuarioRh =. (usuarioRh usuario)]
    returnJson usuarioUpdated

deleteUsuario3R :: UsuarioId -> Handler String
deleteUsuario3R id = do
    runDB $ deleteWhere [UsuarioId ==. id]
    return "Ok"

getUsuario1R :: UsuarioId -> Handler Value
getUsuario1R id = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).    
    maybePerson <- runDB $ selectList ([UsuarioId ==. id]) [LimitTo 1]

    returnJson maybePerson  
