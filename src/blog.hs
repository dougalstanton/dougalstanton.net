{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Applicative
import Data.Monoid

import Hakyll

config = defaultConfiguration
          { deployCommand = "/home/dougal/bin/deploy_blog"
          , destinationDirectory = "/home/dougal/blog/_local"
          , providerDirectory = "/home/dougal/projects/dougalstanton.net"
          }

main :: IO ()
main = hakyllWith config $ do
        match "templates/*" $
            compile templateCompiler

        match "style/*.css" $ do
            route idRoute
            compile compressCssCompiler

        match "*.markdown" $ do
            route   $ setExtension "html"
            compile $ pandocCompiler
                >>= loadAndApplyTemplate "templates/page.html" pageCtx
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
            
        match "posts/*" $ do
            route   $ setExtension "html"
            compile $ pandocCompiler
                >>= loadAndApplyTemplate "templates/page.html" pageCtx
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls

        create ["index.html"] $ do
            route idRoute
            compile $ mkRecentItems
                >>= loadAndApplyTemplate "templates/post-list.html" listContext
                >>= loadAndApplyTemplate "templates/page.html" (emptyField "title" <> pageCtx)
                >>= loadAndApplyTemplate "templates/default.html" homeCtx
                >>= relativizeUrls

        create ["archive.html"] $ do
            route idRoute
            let ctx = mkTitle "Archive"
            compile $ mkAllItems
                >>= loadAndApplyTemplate "templates/post-list.html" listContext
                >>= loadAndApplyTemplate "templates/page.html" (ctx <> pageCtx)
                >>= loadAndApplyTemplate "templates/default.html" (ctx <> defaultContext)
                >>= relativizeUrls


        match "favicon.ico" $ do
            route idRoute
            compile copyFileCompiler
        newfile "CNAME" "dougalstanton.net"

newfile :: Identifier -> String -> Rules ()
newfile name content = create [name] $ do
                        route idRoute
                        compile (makeItem content)
                
mkRecentItems = do
    items <- take 20 . recentFirst <$> loadAll "posts/*"
    tmpl <- loadBody "templates/post-list-item.html"
    list <- applyTemplateList tmpl listContext items
    makeItem list

mkAllItems = do
    items <- recentFirst <$> loadAll "posts/*"
    tmpl <- loadBody "templates/post-list-item.html"
    list <- applyTemplateList tmpl listContext items
    makeItem list

-- pageContext = constField "title" ""
--- postContext = constField "post_menu" ""
listContext = dateContext <> defaultContext
dateContext = dateField "date" "%F"
pageCtx = defaultContext
homeCtx = mkTitle "A Blog" <> defaultContext
emptyField t = constField t ""
mkTitle = constField "title"
