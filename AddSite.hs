{-
  This script takes a sitename string, writes an entry in
  /private/etc/hosts, writes an entry in MAMP/conf/apache/vhosts.conf,
  creates a directory in MAMP/htdocs with a basic index.html file.

  My setup follows what is outlined here:
  http://danilo.ariadoss.com/how-to-setup-virtual-hosts-mamp-environment/
-}

module Main where

import System.Environment (getArgs)
import System.Directory (createDirectory)
import System.IO (openFile, hPutStr, hClose, IOMode( WriteMode ))

main = do
  args <- getArgs
  let sitename = args !! 0
      htdocsPath = "/Applications/MAMP/htdocs/"
  appendFile "/private/etc/hosts" $ hostsStr sitename
  appendFile "/Applications/MAMP/conf/apache/vhosts.conf" $ vhostsStr sitename
  createDirectory $ htdocsPath ++ sitename
  h <- openFile (htdocsPath ++ sitename ++ "/index.html") WriteMode
  hPutStr h ("<h1>Welcome to your new site: " ++ sitename ++ "</h1>")
  hClose h

hostsStr :: String -> String
hostsStr sitename = "127.0.0.1 " ++ sitename ++ "\n"

vhostsStr :: String -> String
vhostsStr sitename = "\n" ++
                    "<VirtualHost *:80>\n" ++
                    "  ServerName " ++ sitename ++ "\n" ++
                    "  DocumentRoot /Applications/MAMP/htdocs/" ++ sitename ++ "\n" ++
                    "</VirtualHost>\n"
