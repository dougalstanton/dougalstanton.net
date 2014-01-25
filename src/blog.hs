{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Monoid ((<>))
import Data.List (isPrefixOf)

import System.Environment (getArgs, withArgs)

import Text.Pandoc.Options (writerHTMLMathMethod, HTMLMathMethod(..))
import Text.Pandoc.Shared (headerShift)
import qualified Text.Pandoc.Definition as P
import qualified Text.Pandoc.Generic as P

import Hakyll

buildConfig = defaultConfiguration
          { deployCommand = "/Users/dougal/bin/deploy_blog"
          , destinationDirectory = "/Users/dougal/Documents/blog/_local"
          , providerDirectory = "/Users/dougal/Projects/dougalstanton.net"
          , storeDirectory = "/Users/dougal/Projects/dougalstanton.net/_cache"
          , tmpDirectory = "/Users/dougal/Projects/dougalstanton.net/_cache/tmp"
          }

draftConfig = buildConfig
    { destinationDirectory = "/Users/dougal/Documents/blog/_tmp"
    , storeDirectory = "/Users/dougal/Documents/blog/_tmp/_cache"
    , tmpDirectory = "/Users/dougal/Documents/blog/_tmp/_cache/tmp"
    }

feed = FeedConfiguration
        { feedTitle = "Looking Out To Sea"
        , feedDescription = "A blog of sorts, unsorted."
        , feedAuthorName = "Dougal Stanton"
        , feedAuthorEmail = "blog@dougalstanton.net"
        , feedRoot = "http://dougalstanton.net"
        }

-- We can downshift the h1 headers to h3 headers, allowing the
-- flexibility to write standalone Markdown documents but still
-- include them in larger pages.
pandoc :: Compiler (Item String)
pandoc = pandocIncluding []

pandocIncluding :: [Item String] -> Compiler (Item String)
pandocIncluding includes =
    pandocCompilerWithTransform ropts wopts
        (headerShift 2 . P.bottomUp (doInclude includes))
    where
        ropts = defaultHakyllReaderOptions
        wopts = defaultHakyllWriterOptions { writerHTMLMathMethod = MathML Nothing }

doInclude :: [Item String] -> P.Block -> P.Block
doInclude includes cb@(P.CodeBlock (i, cs, namevals) _) =
    case lookup "include" namevals of
        Just path -> P.CodeBlock (i, cs, namevals)
                                 (case lookup path allIncludes of
                                       Just item -> itemBody item
                                       Nothing   -> "Missing source file: " ++ path)
        Nothing    -> cb
    where
        allIncludes = map (\i -> (toFilePath $ itemIdentifier i, i)) includes
doInclude _ x = x

-- Create a new field from an existing one, replacing some characters
-- with HTML entities so they display nicer.
smarterField :: String -> Context String
smarterField key = field key $ \i -> do
                        value <- getMetadataField (itemIdentifier i) key
                        return $ maybe "" smarten value

smarten :: String -> String
smarten txt | null txt               = txt
            | "---" `isPrefixOf` txt = "&mdash;" ++ (smarten $ drop 3 txt)
            | "--"  `isPrefixOf` txt = "&ndash;" ++ (smarten $ drop 2 txt)
            | "..." `isPrefixOf` txt = "&hellip;" ++ (smarten $ drop 3 txt)
smarten (c:cs) = c:smarten cs

main :: IO ()
main = do
    args <- getArgs
    case args of
     ("drafts":xs) -> withArgs ("build":xs) (blog True)
     ("alldrafts":xs) -> withArgs ("rebuild":xs) (blog True)
     _           -> blog False

blog draftOnly =
    let (config,posts) = if draftOnly
                            then (draftConfig, "drafts/*")
                            else (buildConfig, "posts/*")
    in hakyllWith config $ do
        match "templates/*" $
            compile templateCompiler

        match "includes/**" $
            compile getResourceBody

        match "style/*.css" $ do
            route idRoute
            compile compressCssCompiler

        match "*.markdown" $ do
            route   $ setExtension "html"
            compile $ pandoc
                >>= loadAndApplyTemplate "templates/page.html" pageCtx
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

        match "pages/*" $ do
            route   $ setExtension "html"
            compile $ pandoc
                >>= loadAndApplyTemplate "templates/page.html" pageCtx
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

        match posts $ do
            route   $ setExtension "html"
            compile $ loadAll "includes/**"
                >>= pandocIncluding
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/page.html" pageCtx
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

        match "index.html" $ do
            route idRoute
            compile $ do
                posts <- fmap (take 15) . recentFirst =<< loadAll posts
                let indexCtx = listField "posts" listContext (return posts)
                                    <> emptyField "title" <> listContext
                getResourceBody
                    >>= applyAsTemplate indexCtx
                    >>= loadAndApplyTemplate "templates/page.html" indexCtx
                    >>= loadAndApplyTemplate "templates/default.html" homeCtx
                    >>= relativizeUrls

        create [fromFilePath "archive.html"] $ do
            route idRoute
            let ctx = mkTitle "Archive"
            compile $ do
                let arcCtx = listField "posts" listContext (loadAll "posts/*" >>= recentFirst) <>
                             ctx <> listContext
                makeItem ""
                    >>= loadAndApplyTemplate "templates/archive.html" arcCtx
                    >>= loadAndApplyTemplate "templates/page.html" arcCtx
                    >>= loadAndApplyTemplate "templates/default.html" arcCtx
                    >>= relativizeUrls

        mkFeed "atom.xml" renderAtom
        mkFeed "rss.xml" renderRss

        match "favicon.ico" $ do
            route idRoute
            compile copyFileCompiler
        newfile (fromFilePath "CNAME") "dougalstanton.net"

newfile :: Identifier -> String -> Rules ()
newfile name content = create [name] $ do
                        route idRoute
                        compile (makeItem content)

mkFeed :: String
       -> (FeedConfiguration -> Context String -> [Item String] -> Compiler (Item String)) -> Rules ()
mkFeed name renderer = create [fromFilePath name] $ do
    route idRoute
    compile $ do
        let feedCtx = pageCtx <> bodyField "description"
        posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
        renderer feed feedCtx posts

-- Miscellaneous contexts, could do with a clean up.
listContext = dateField "date" "%F" <> pageCtx
pageCtx = smarterField "title" <> defaultContext
homeCtx = mkTitle "A Blog" <> pageCtx
emptyField t = constField t ""
mkTitle = constField "title"
